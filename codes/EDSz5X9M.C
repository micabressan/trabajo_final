#include <stdio.h>
#include <conio.h>
#include <time.h>

struct GoldbachPair
{
	int Prime1 = 0, Prime2 = 0;
};

bool IsPrime(const int value)
{
	for (int i = 2; i * i <= value; i++)
		if (value % i == 0)
			return false;

	return true;
}

bool IsPrimeNaive(const int value)
{
	for (int i = 2; i <= value; i++)
		if (value % i == 0)
			return false;

	return true;
}

GoldbachPair Goldbach(const int value)
{
	GoldbachPair pair;
	pair.Prime1 = pair.Prime2 = 0;

	for (int i = 2; i < value ; i++)
		if (IsPrime(pair.Prime1 = i) && IsPrime(pair.Prime2 = value - i))
			return pair;
}

GoldbachPair GoldbachNaive(const int value)
{
	GoldbachPair pair;
	pair.Prime1 = pair.Prime2 = 0;

	for (int i = 2; i < value; i++)
		if (IsPrimeNaive(pair.Prime1 = i) && IsPrimeNaive(pair.Prime2 = value - i))
			return pair;
}

int main()
{
	int periods[] = { 2000000, 3000000, 4000000};
	GoldbachPair pair;
	clock_t start, end;
	for (int i = 0; i < 3; i++)
	{
		printf("Przedzial: (6 : %d)\n", periods[i]);
		start = clock();
		//#pragma omp parallel for shared(periods) private(pair)
		for (int j = 6; j < periods[i]; j+=2)
		{
			pair = Goldbach(j);
			//printf("Liczbe %d mozna przedstawic jako sume liczb pierwszych: %d oraz %d\n", j, pair.Prime1, pair.Prime2);
		}
		end = clock();
		printf("Czas wykonywania dla zadanego przedzialu: %d s\n\n", (end - start) / CLOCKS_PER_SEC);
	}
	_getch();
}