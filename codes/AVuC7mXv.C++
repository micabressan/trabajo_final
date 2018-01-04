// если компилятор visual studio 2012 и выше 
//#include "stdafx.h"


#include <vector>
#include <iostream>
#include <conio.h>  // для getch()

using namespace std;


void PrintMatrix(vector<vector<int>> mtrx)
{
	for(auto vec : mtrx)
	{
		for(auto j : vec)
			cout << j << ' ';
		cout << endl;
	}
}
 
/*
функция поиска минимального элемента в матрице
*/

int MinElementMatrix(vector<vector<int>> mtrx, size_t N)
{
	int min = mtrx[0][0];         // сначала min равен первому элементу матрицы.
	for(size_t i = 0; i < N; i++)
		for(size_t j = 0; j < N; j++)
			if(mtrx[i][j] < min) min = mtrx[i][j]; // если текущий элемент меньше min, тогда минимальный равен текущему.

	return min;
}

/* Количество локальнных минимумов в матрицы */

int CountMinElement(vector<vector<int>> mtrx, size_t N)
{
	int min = MinElementMatrix(mtrx, N); // инициализация минимального элемента 
	int count = 0; 

	for(size_t i = 0; i < N; i++)
		for(size_t j = 0; j < N; j++)
			if(mtrx[i][j] == min) count++; // если равен увеличиваем счётчик количества локальных минимумов

	return count;
}

int SumElements(vector<vector<int>> mtrx, size_t N)
{
	int sum = 0;
	for(size_t i = 0; i < N; i++)
		for(size_t j = 0; j < N; j++)
		{
			// элементы выше главной диагонали
			if(i < j) sum += abs(mtrx[i][j]); // abs - стандартная функция модуля
		}

	return sum;
}

int main(int argc, char ** argv)
{
	setlocale(0,"Rus");	
	
	size_t N;
	cout << "Введите N "; cin >> N;

	vector<vector<int>> mtrx(N);
// Заполнение
    for(size_t i = 0; i < N; ++i)
    {
        mtrx[i].resize(N);
        for(size_t j = 0; j < N; ++j)
            mtrx[i][j] = rand() % 5; 
    }
    PrintMatrix(mtrx);
	

	cout << "\nЛокальный минимум "               << MinElementMatrix(mtrx, N) << endl;
	cout << "\nКоличество локальных минимумов  " << CountMinElement(mtrx, N)  << endl;

	cout << "\nСумма модулей элементов выше главной диагонали  " << SumElements(mtrx, N) << endl;

	
	_getch(); // задержка окна
	return 0;
}