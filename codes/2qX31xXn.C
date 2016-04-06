typedef unsigned int uint;

int badd(int a,int b)
{
	uint carry = 0;
	uint mask = 1;
	uint r = 0;

	r = a ^ b;

	for(uint i = 0;i < 32;i++)
	{
		uint mA = a & mask;
		uint mB = b & mask;

		r ^= carry;

		carry = ((mA & carry) | (mB & carry) | (mA & mB)) << 1u;
		mask <<= 1u;
	}

	return r;
}