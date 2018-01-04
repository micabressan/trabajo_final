
#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>

void FillArray(int** const arr, const int n, const int m) // 1 упраж
{
	printf("\nВводите элементы: \n");
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < m; j++)
		{
			scanf_s("%d", &arr[i][j]);
		}
	}
}

void ShowArray(int** const arr, const int n, const int m)// 1 упраж
{
	printf("\nВаша матрица: \n");
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < m; j++)
		{
			printf("\t%d", arr[i][j]);
		}
		printf("\n");
	}
}

int math(int** const arr, const int n, const int m)// 1 упраж
{
	int clk = -1;
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < m; j++)
		{
			if (arr[i][j] != 0)
			{
				break;
			}
			else if (j == m - 1)
				clk = i + 1;
		}
	}
	return clk;
}

int main()
{
	SetConsoleOutputCP(1251);

	///////////////////////////////////
	//Упр 1 лаб 7 //
	//////////////////////////////////

	printf("Вволите размер матрицы: ");
	int n = 0, m = 0;
	scanf_s("%d %d", &n, &m);

	int** arr = (int**)malloc(n * sizeof(int*));
	for (int i = 0; i < n; i++)
	{
		arr[i] = (int*)malloc(m * sizeof(int));
	}

	FillArray(arr, n, m);
	ShowArray(arr, n, m);
	int num = -1;
	num = math(arr, n, m);

	num > 0 ? printf("\nСтрока: %d\n", num) : printf("\nСтроки со всеми нулевыми элементами не существует!\n");

	for (int i = 0; i < n; i++)
		free(arr[i]);
	free(arr);


	system("pause");
	return 0;
}