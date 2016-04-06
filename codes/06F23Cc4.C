/*
NOTICE: You must define the following: 

LUTSIZEP2
DELAYSIZEP2
INITSTEP

via compile options, or it won't compile.
*/

/* 
**README
Collatz Delay openCL kernel with 256-step sieve, by Sosiris, BOINC@Taiwan, 2015 C.E.
How this thingy works : 
I Scan the numbers vertically instead of horizontally.
Let n0 = a0 * (offset + id) + b0, where a0 = 2^256, b0 = one of the # in the 256-step sieve, offset = offset by kernel launch (kNo) + offset by initial conditions
We can calculate it 256 steps ahead in the host, as all numbers share the same path until (256+1)th step: 
n256 = a256 * (offset + id) + b256, where a256 = 3^(odd b's encountered), b256 = b0 after 256 steps
And n256 = (a256 * id) + (a256 * offset + b256), the former is computed by the openCL kernel, the latter (call it totalOffset) by the host
Moreover, since offset = offset by kernel launch (kNo) + offset by initial conditions, and kNo increased by 1, offset increased by 'global threads' for every kernel launch,
the increment of totalOffset = a256 * globalThreads, which can be computed in the device to decrease device-host communication


**Work flow proposed for this app:
kNo = lastkNo; //resume from last checkpoint
totalOffset = getTotalOffset(a256, b256, offset + kNo * globalThreads);
increment = a256 * globalThreads;
for (k from 1 to range)
{
	kernel_clearRes (result[]);
	for(i from 1 to kernelsPerReduction)
	{
		kernel_collatzDelay(result[], lut[], delay[], a256, totalOffset, kNo);
		kernel_incTotalOffset(totalOffset, increment);
		++kNo;
	}
	readAndCompareResult (result[]);
	checkPoint(kNo);
}

*/

//preprocessor defines
#define LUTMASK ((1u<<LUTSIZEP2)-1)
#define DELAYMASK ((1u<<DELAYSIZEP2)-1)
#define NUMLENGTH 16
#define MAXSTEP 0xfffffffu

//Power of 3
__constant uint power3[21] = {
1u,3u,9u,27u,81u,243u,729u,2187u,6561u,19683u,
59049u,177147u,531441u,1594323u,4782969u,14348907u,43046721u,129140163u,387420489u,1162261467u,
3486784401u};

//returns a*b+c in uint2
inline uint2 mad64(const uint a, const uint b, const uint c)
{
	uint2 res = (uint2)(a*b, mul_hi(a,b));
	res.s0 += c;
	res.s1 += res.s0 < c;
	return res;
} //mad64()

/*
collatzDelay():
g_maxStep : s0 = max collatz delay, s1 = corresponding kNo; length = global threads
g_totalSteps : accumulated collatz delay steps; length = global threads
g_lut : look-up table to 'jump', s0 : value should be multiplied (presented as 3^x), s1 : value should be added; length = 2^(LUTSIZEP2)
g_delay : collatz delays for # under 2^(DELAYSIZEP2), length = 2^(DELAYSIZEP2)
c_a : a256 stored in 512-bit, length = NUMLENGTH (=16)
c_totalOffset : totalOffset stored in 512-bit, length = NUMLENGTH (=16)
kNo : offset from each kernel launch, 1 kNo = offset of 'global threads'
*/

__kernel void collatzDelay
(
	__global uint2 *g_maxStep,
	__global ulong *g_totalSteps,
	__global const uint2 *g_lut,
	__global const uint *g_delay,
	__constant uint *c_a,
	__constant uint *c_totalOffset,
	const uint kNo
)
{
	uint gid = get_global_id(0);
	uint val[NUMLENGTH];
	uint2 lut = (uint2)0;
	ulong addRes = 0;
	//val = a * gid 
	#pragma unroll
	for(int i=0 ; i<NUMLENGTH ; ++i)
	{
		lut = mad64(c_a[i], gid, lut.s1);
		val[i] = lut.s0;
	} //for()
	//val += totalOffset
	#pragma unroll
	for(int i=0 ; i<NUMLENGTH ; ++i)
	{
		addRes = (addRes>>32) + val[i] + c_totalOffset[i];
		val[i] = convert_uint(addRes);
	} //for()

	uint index = 0;
	uint steps = INITSTEP;

	do
	{
		index = val[0] & LUTMASK;
		lut = g_lut[index];
		steps += LUTSIZEP2 + lut.s0;
		index = power3[lut.s0]; //index as mulVal

		//val = val>>LUTSIZEP2
		#pragma unroll
		for(int i=0 ; i<NUMLENGTH-1; ++i)
		{
			val[i] = (val[i] >> LUTSIZEP2) | (val[i+1] << (32-LUTSIZEP2));
		} //for()
		
		val[NUMLENGTH -1] >>= LUTSIZEP2;

		//val = val * 3^(lut.s0) + lut.s1
		#pragma unroll
		for(int i=0 ; i<NUMLENGTH; ++i)
		{
			lut = mad64(val[i], index, lut.s1);
			val[i] = lut.s0;
		}

		//compare val to DELAYMASK, if val > DELAYMASK, index is positive; else, 0
		index = val[0] > DELAYMASK;
		#pragma unroll
		for(int i=1 ; i<NUMLENGTH; ++i)
		{
			index |= val[i];
		}
		//if step >= MAXSTEP or val overflowed, stop the loop
		index = index && (steps < MAXSTEP) && (!lut.s1);
	} while(index);

	steps += g_delay[val[0] & DELAYMASK];
	steps = select(steps, MAXSTEP, lut.s1);
	addRes = g_totalSteps[gid];
	addRes += steps;
	g_totalSteps[gid] = addRes;
	lut = g_maxStep[gid];
	index = -(steps > lut.s0);
	lut = select(lut, (uint2)(steps, kNo), (uint2)index);
	g_maxStep[gid] = lut;
} //collatzDelay()

__kernel void clearRes
(
	__global uint2 *g_maxStep,
	__global ulong *g_totalSteps
)
{
	uint gid = get_global_id(0);
	g_maxStep[gid] = (uint2)0;
	g_totalSteps[gid] = 0;
} //clearRes()


__kernel void incTotalOffset
(
	__global uint *g_totalOffset,
	__constant uint *c_increment
)
{
	__local ulong l_addRes[NUMLENGTH];
	__local uint l_res[NUMLENGTH];

	uint gid = get_global_id(0);
	l_addRes[gid] = g_totalOffset[gid] + c_increment[gid];
	barrier(CLK_LOCAL_MEM_FENCE); //actually not required right now in AMD GPUs, because its wavefront size is 64, bigger than NUMLENGTH (16)
	if(gid == 0)
	{	
		l_res[0] = convert_uint(l_addRes[0]);
		#pragma unroll
		for(int i=1;i<NUMLENGTH;++i)
		{
			l_addRes[i] += (l_addRes[i-1]>>32); //carry
			l_res[i] = convert_uint(l_addRes[i]);
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	g_totalOffset[gid] = l_res[gid];
}//incTotalOffset()