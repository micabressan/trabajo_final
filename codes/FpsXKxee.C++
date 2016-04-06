#include <iostream>
#include <conio.h>
#include <math.h>
using namespace std;
int a[3000000]; // tablica, w której zapiszemy zapis binarny liczby, którą będziemy sprawdzać, czy da się ją otrzymać
int p[3000000]; // p[i] to liczba dostępnych i-tych potęg dwójki

int main()
{
	int k;
	cin >> k;
	for(int i=0; i<k+1; i++)
		cin >> p[i];
	

// największa możliwa liczba do rozłożenia:	p[j]*pow(2, j);
/* najmniejsza możliwa liczba do rozłożenia: 
	int minimum = p[0];
	int i = 0;
	while(i<=k)
	{
		if(minimum > p[i])
			minimum = p[i];
		i++;
	}
	int j = minimum*(2^(k+1) - 1) + 1;
	*/
	
	// USTALENIE NAJMNIEJSZEJ MOŻLIWEJ LICZBY, KTÓRA MOŻE BYĆ NIEROZKŁADALNA
	int minimum = p[0];
	int i = 0;
	while(i<=k)
	{
		if(minimum > p[i])
			minimum = p[i];
		i++;
	}
	int n = minimum*(2^(k+1) - 1) + 1;
	short y = 0; // do zakończenia pętli
	while(y == 0) // pętla zwiększająca n, aż do momentu, gdy znajdziemy n, którego się nie da rozłożyć
	{
		// ROZKŁAD N NA POTĘGI
		int i = 0;
		// szukamy największej potęgi 2^i <=n
		while(pow(2,i)<n)
			i++;
		if(n-pow(2,i) == 0)
			a[i] = 1;
		else
		{
			a[i-1] = 1;
			// odejmujemy tę potęgę
			n -= pow(2,i-1);
			i -= 2;
			// pętla zmniejszająca i o 1 i sprawdzająca relację większosci względem n
			while(n>0)
			{
				if(pow(2,i)>n)
					i--;
				else
				{
					a[i] = 1;
					n -= pow(2,i);
					i--;
				}
			}
		}
		//N ROZŁOŻONE W TABLICY A NA CZYNNKIKI
		for(int z = 3000000; z>0; z--)
		{
			if(a[z] > p[z])
			{	
				a[z-1] += 2*(a[z] - p[z]);
			}
			//else: po prostu idziemy dalej, bo w takim wypadku: 1. gdy a[z]<p[z], to pozostała liczba (utworzona przez a[z-1]) i tak jest mniejsza od 2^p[z]; 2. gdy a[z]=p[z], nie mamy co zrobić
		}
		if(a[0]>p[0])
		{
			cout << n;
			y = 1; // żeby zakończyć pętlę
		}
		else
		{
			//da się, więc
			n++;
		}

	}
	getch();
}