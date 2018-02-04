#define NOMINMAX     // due to conflict with max()
#include <windows.h> // warning: no C++ standard!

#include "MyBigUnsigned.h" // http://henkessoft.de/Sonstiges/MyBigUnsigned.rar 
                           // based on https://mattmccutchen.net/bigint/
#include <iostream>
#include <cstdint>
#include <vector>
#include <cassert>
#include <thread>
#include <mutex>

using namespace std;

const uint32_t numberOfThreads = 11;
const uint32_t DIVISOR_PRECHECK_K_MAX = 600;
uint64_t const primeLimit = 100000000;
uint64_t frequency;

mutex mutex0;

void textcolor(unsigned short color = 15)
{
	SetConsoleTextAttribute(::GetStdHandle(STD_OUTPUT_HANDLE), color);
}

uint64_t convertBigToU64(BigUnsigned num)
{
	BigUnsigned ZweiHochVierUndSechzig = stringToBigUnsigned("18446744073709551616");
	assert(num < ZweiHochVierUndSechzig);
	uint64_t jHi = num.getBlock(1);
	uint64_t jLo = num.getBlock(0);
	return (jHi << 32 | jLo);
}

void convertU64ToBig(uint64_t num, BigUnsigned& b)
{
	uint32_t numLo = (uint32_t)(num & 0xFFFFFFFF);
	uint32_t numHi = (uint32_t)((num >> 32) & 0xFFFFFFFF);
	b.setBlock(0, numLo);
	b.setBlock(1, numHi);
}

BigUnsigned calculateMersenneNumber(BigUnsigned p)
{
	BigUnsigned x = 2;

	for (BigUnsigned i = 1; i < p; ++i)
	{
		x <<= 1;
	}
	return (x - 1);
}

bool LucasLehmerTest(BigUnsigned m, BigUnsigned p)
{
	BigUnsigned s = 4;

	for (BigUnsigned i = 2; i < p; ++i)
		s = (s*s - 2) % m;

	return (s == 0);
}

// division test with 2*k*p+1
BigUnsigned divisionPrecheck(BigUnsigned m, BigUnsigned p)
{
	for (BigUnsigned k = 1; k <= DIVISOR_PRECHECK_K_MAX; ++k)
	{		
		BigUnsigned Divisor = k * p;
		Divisor <<= 1; // 2 * k * p 
		Divisor += 1; // 2 * k * p +1 

		if (m % Divisor == 0)
		{
			return k;
		}		
	}

	return 0; // No divisor found
}

void mersennePrimeCheck(vector<bool>& primes, uint64_t startCount, uint64_t lastCount, uint64_t startP, uint64_t limitP)
{
	BigUnsigned bigStartP, bigLimitP;
	convertU64ToBig(startP, bigStartP);
	convertU64ToBig(limitP, bigLimitP);

	for (BigUnsigned p = bigStartP; p < bigLimitP; ++p)
	{
		// primes lookup for p // In order for M(p) to be prime, p must itself be prime.
		if (!primes[convertBigToU64(p)])
			continue;
		
		// if p is prime, then we calculate the mersenne number
		BigUnsigned m = calculateMersenneNumber(p);
		
		// mersenne numbers with prime factors are no mersenne primes
		if (p > 19)
		{ 
			BigUnsigned divisor = divisionPrecheck(m,p);
			if (divisor !=0)
			{
				/*
				mutex0.lock();
				textcolor(3);
				cout << ">>> divisionPrecheck (2*k*p+1) finds k = " << divisor << " for p = " << p << " <<<" << endl;
				mutex0.unlock();
				*/
				continue;			
			}
		}
		
		if (LucasLehmerTest(m, p))
		{
			QueryPerformanceCounter((LARGE_INTEGER*)&lastCount);
			uint64_t delta = lastCount - startCount;

			mutex0.lock();
			textcolor(15);
			cout << "p: " << p; 
			textcolor(2);
			cout << "\ttime: " << 1000 * delta / frequency << " ms" << endl;
			mutex0.unlock();
		}
	}
	
	mutex0.lock();
	textcolor(11);
	cout << "work is done for " << bigStartP << " to " << bigLimitP-1 << endl;
	mutex0.unlock();
}

int main()
{
	uint64_t startCount = 0, lastCount = 0, delta = 0;
	QueryPerformanceFrequency((LARGE_INTEGER*)&frequency);
	cout << "cpu frequency: " << frequency << " Hz" << endl;
	cout << "DIVISOR_PRECHECK_K_MAX: " << DIVISOR_PRECHECK_K_MAX << endl;
	cout << "number of threads: " << numberOfThreads << endl;
	
	////////////////////////// Generate primes lookup table /////////////////////////////////////////////////////////////

	vector<bool> primes(primeLimit + 1); // calculated primes (low values)
	
	primes[0] = primes[1] = false;
	for (uint64_t i = 2; i < primeLimit + 1; ++i) { primes[i] = true; }

	// Erastothenes sieving loop
	uint64_t iMax = (uint64_t)sqrt((double)primeLimit) + 1;
	for (uint64_t i = 2; i < iMax; ++i)
	{
		if (primes[i])
		{
			for (uint64_t j = 2 * i; j < primeLimit + 1; j += i)
			{
				primes[j] = false;
			}
		}
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	cout << "Lucas Lehmer prime test for mersenne numbers" << endl; // https://de.wikipedia.org/wiki/Lucas-Lehmer-Test

	QueryPerformanceCounter((LARGE_INTEGER*)&startCount);

	vector<thread> t;
	uint64_t startP = 0;
	uint64_t limitP = 2400;

	for (int x = 0; x < numberOfThreads; ++x)
	{
		t.emplace_back(mersennePrimeCheck, primes, startCount, lastCount, startP + x * 2400, limitP + x * 2400);
	}

	for (int x = 0; x < numberOfThreads; ++x)
	{
		t[x].join(); // main has to wait for the results of the threads. 
	}
}