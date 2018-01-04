// ConsoleApplication23.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <stdio.h>
#include <cstdlib>
#include <string.h>
#include <string.h>


int main()
{
	FILE *plik1,*plik2, *plik3, *plik4;
	int i = 0;
	char tab[150];
	char tab1[150];
	char tab2[150];
	char tab3[500];
	printf("Damian Mizielski\n");
	fopen_s(&plik1, "1.txt", "r");
	fgets(tab, sizeof tab, plik1);
	fopen_s(&plik2, "2.txt", "r");
	fgets(tab1, sizeof tab, plik2);
	fopen_s(&plik3, "3.txt", "r");
	fgets(tab2, sizeof tab, plik3);
	fopen_s(&plik4, "string.txt", "w");
	strcpy_s(tab3, tab);
	strcat_s(tab3, tab1);
	strcat_s(tab3, tab2);
	fprintf(plik4, tab3);
	_fcloseall();
	system("pause");
    return 0;
}