#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include "double_error.cpp"
using namespace std;

void testSum()
{
	Double result1 = 0;
	Double result2 = 0;
	for (double i = 100 - 0.001; i >= 1; i -= 0.001)
		result1 = (result1 + i);
	for (double i = 1; i < 100; i += 0.001)
		result2 = (result2 + i);

	puts("Test sum [1..100) with step 0.001:");
	result1.print();
	result2.print();
	puts("-------------------------------");
}

int main()
{
	testSum();
	return 0;
}

/*
Test sum [1..100) with step 0.001:
4999449.4999891939+-(2.853744e-05)
4999450.5000004042+-(1.357398e-05)
-------------------------------
*/