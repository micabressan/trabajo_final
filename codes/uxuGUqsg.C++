#include <stdio.h>
//#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <cstdio>
#define inf 100000
 
#define MIN(a,b) (a<b)?a:b //sprawdzenie czy a jst mniejsze od b. Jesli tak, to a, jesli nie, to b
 
int	 main()
{
FILE *plik;
int     n; //liczba wierzcholkow
int     A[100][100]; //waga krawedzi dla kazdej pary wierzcholkow u i v
int     D[100]; //gorne oszacowanie odleglosci 
char    s[5];
int     k, v, u;
int C; 
int poprzedniki[5];

//brak krawedzi oznacza *, v- wierzcholek, u-poprzednik
if ((plik=fopen("graf.txt","r"))==NULL) 
	printf("Brak pliku graf.txt!\n"); 
else {
		fscanf(plik,"%i",&n); 
		printf("Liczba wierzcholkow: %i\n",n);

		for (u=0; u<n; u++) 
			for (v=0; v<n; v++)
				{
					fscanf(plik,"%s",s); 
					if (strcmp(s,"*")!= 0) //jeżeli jest *, to nie ma polaczenia i idziemy do else
						A[u][v]=atoi(s);  //convert from str to int
					else A[u][v]=inf; //gdy krawedz nie istnieje
				}
		fclose(plik);
		 
		for (v=0; v<n; v++){
			D[v]=A[0][v]; // s=1, szukamy najkrótszych dróg od wierzchołka 1 do pozostałych
			poprzedniki[v] = 0;
		}
		//for (k=1;k<=n-2;k++) //w n-2 krokach mozna zbadac kazda droge o n-1 krawedziach i wybrac najkrotsza
		//	{
				for (u = 0; u < n; u++)
					{
						for (v = 1; v < n; v++) 
							{
								//if (D[u]+A[u][v]>inf)
								//	C=inf; 
								//else 
								//	{
										C=D[u]+A[u][v];
										//D[v]=MIN(D[v],C); //wybieranie najkrotszej drogi 
										if (C < D[v]){
											D[v] = C;
											poprzedniki[v] = u;
										}

									//}
							}

						
					}
			
		//	}

		k=inf;

		for (v=0;v<n;v++)
		{
			if (D[v]<k)
				//printf("\n D(%i)=%i, droga: %i\n", v+1, D[v], P[u]);
				std::cout << "D(" << v+1 << ")=" << D[v] << ",  droga: " << poprzedniki[v] << std::endl;
			else
				//printf("\n D(%i)=%s\n",v+1,"*");
				std::cout << "D(" << v+1 << ")=" << "*" << std::endl;
		}
	}
return 0;
}