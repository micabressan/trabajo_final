#include<iostream>
#include<cstdlib>
#include<time.h>

using namespace std;
#define SIZE 10

void init(int tab[], int size = SIZE);

void wys(int tab[], int size = SIZE);

void zamien(int& a, int& b);

void sortowanie_b(int tab[], int size = SIZE);

void sortowanie_w(int tab[], int size = SIZE);

void sortowanie_wyb(int tab[], int size = SIZE);

int main()
{
	srand(time(NULL));
	int tab[SIZE];

	init(tab);
	wys(tab);

	int suma = 0;
	for (int i = 0; i < SIZE; i++)
	{
		suma += tab[i];
		if (suma > 200)
		{
			cout << "Koniec dla i=" << i << endl;
			break;
		}
	}

	char znak;
	znak = cin.get();
	do
	{
		cin.get(znak);
		cin.ignore(100, '\n');
		switch (znak)
		{
		case '1':
			cout << "Sortowanie babelkowe" << endl;
			break;

		case '2':
			cout << "Sortowanie przez wstawianie" << endl;
			break;

		case '3':
			cout << "Sortowanie przez wybieranie" << endl;
			break;

		case 'q':
			cout << "Koniec" << endl;
			break;

		default:
			cout << "Zly znak" << endl;
			break;
		}
	} while (znak != 'q');
	for (int i = 0; i < SIZE; ++i)
	{
		tab[i] = i + 1;
	}
	
	wys(tab);
	cout << endl;
	cout << "sortowanie babelkowe";
	sortowanie_b(tab, SIZE);
	wys(tab);
	
	int array_a[SIZE];
	init(array_a, SIZE);
	
	wys(array_a);
	cout << endl;
	cout << "sortowanie poprzez wstawianie" << endl;
	sortowanie_w(array_a, SIZE);
	wys(array_a);
	
	int array_b[SIZE];
	init(array_b, SIZE);

	wys(array_b);
	cout << endl;
	cout << "sortowanie przez wybieranie";
	sortowanie_wyb(array_b, SIZE);
	wys(array_b);
	
	cin.get();
	return 0;
}

void init(int tab[], int size)
{
	for (int i = 0; i < size; i++)
		tab[i] = rand() % 100;
}

void wys(int tab[], int size)
{
	for (int i = 0; i < size; i++)
		cout << tab[i] << endl;
}

void zamien(int& a, int& b)
{
	int c = a;
	a = b;
	b = c;
}

void sortowanie_b(int tab[], int size)// sortowanie babelkowe
{
	for (int i = 0; i < size; i++)
	{
		for (int n = size - 1; n > i; --n)
			if (tab[n] > tab[n - 1])
				zamien(tab[n], tab[n - 1]);
	}
}
void sortowanie_w(int tab[], int size)// sortowanie poprzez wstawianie
{
	for (int i = 1; i < size; i++)
	{
		int b = tab[i];
		for (int n = i - 1; n >= 0;n--)
			if (tab[n] > b){
				tab[n + 1] = tab[n];
				if (n == 0){
					tab[n] = b;
				}
				else {
					tab[n + 1] = b;
					break;
				}
			}
	}
}
void sortowanie_wyb(int tab[],int size)// sortowanie przez wybieranie
{
	int min;
	for (int i = 0; i < size; i++)
	{
		min = i;
		for (int n = i + 1; n < size, n++;)
		{
			if (tab[min] > tab[n])
			{
				min = n;
			}
			if (min != i)
				zamien(tab[i], tab[min]);
		}
	}
}
void zamien(int *a, int *b);

int main()
{
	int a = 23;
	int*b = &a;// zmienna wskaznikowa/pobierz adres zmiennej a
	*b = 87;
	
	zamien(&a, b);
	b = new int; 
	*b = 33;
	delete b;

	b = &a;

	cout << "a=" << a << " " << "b=" << b <<"  "<< " &a="<< &a<< " " <<"*b="<< *b<<" "<< endl;
	
	cin.get();
	return 0;
}
void zamien(int *a, int *b)
{
	int c = *a;
	*a = *b;
	*b = c;
}