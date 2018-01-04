#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
int x;
int y;
int x2;
int y2;
int NumberOfThreads;
int wiersz=0;
int macierzA[20][20];
int macierzB[20][20];
int macierzC[20][20];
void *mnozenie (void*);
int main()
{
	pthread_t tid[NumberOfThreads];
	printf ("Podaj ilość wierszy macierzy A:\n");
	scanf("%d",&x);
	printf ("Podaj ilość kolumn macierzy A:\n");
	scanf("%d",&y);
	printf ("Podaj ilość wierszy macierzy B:\n");
	scanf("%d",&x2);
	printf ("Podaj ilość kolumn macierzy B:\n");
	scanf("%d",&y2);
	printf ("Podaj ilość wątków:\n");
	scanf("%d",&NumberOfThreads);
	if(y!=x2)
	{
		printf("Nie można pomnożyć tych macierzy.\n");
		exit (0);
	}
	printf("Macierz A:\n");
	for(int i=0; i<x; i++)
	{
		for(int j=0; j<y; j++)
		{
			macierzA[i][j] = rand()%2;
			printf("%d",macierzA[i][j]);
			
		}
	printf("\n");
	}
	printf("Macierz B:\n");
	for(int i=0; i<x2; i++)
	{
		for(int j=0; j<y2; j++)
		{
			macierzB[i][j] = rand()%2;
			printf("%d",macierzB[i][j]);
		}
	printf("\n");
	}
	for(int i=0; i<NumberOfThreads; i++)
	{
		pthread_create(&tid[i],NULL,mnozenie,wiersz);
		pthread_join(tid[i], NULL);
		wiersz ++;
		if(i==NumberOfThreads)
			i=0;
		if (wiersz == x)
			break;
	}
	printf ("Macierz C: \n");
	for (int i=0; i<x ; i++)
	{
		for(int j=0; j<y2; j++)
		{
			printf("%d", macierzC[i][j]);
		}
	printf ("\n");
	}
			
}
void *mnozenie (void* p)
{
	int* a;
	a = (int *)p;
	a = &wiersz;
	for(int j=0; j<x2; j++)
	{
		for(int i=0; i<x; i++)
		{
			if(macierzA[wiersz][i]==1 && macierzB[i][wiersz]==1)
				macierzC[wiersz][j] =1;
			else
				macierzC[wiersz][j] =0;
			
		}

	}
}