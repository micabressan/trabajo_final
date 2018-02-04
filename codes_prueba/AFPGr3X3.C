#include<stdio.h>

int main()
{
	int n;
	printf("podaj ilosc liczb: ");
	scanf("%d",&n);
	int tab[n], suma=0;
	
	for(int i=0;i<n;i++)
	{
		printf("podaj %d. liczbe: ",i+1);
		scanf("%d",&tab[i]);
		suma+=tab[i];	

	}
	double srednia;
	srednia=suma/n;
	printf("suma to %d\nsrednia to %f\n",suma,srednia);
}