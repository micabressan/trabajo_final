#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include "windows.h"
#include "time.h"

using namespace std;

void main() {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	const short int n = 5, m = 5;
	int a[n][m];
	cout << "Формируем и выводим матрицу" << endl;
	for (int i = 0; i < n; i++) {
		srand(time(NULL) + i * rand() % 50);
		for (int j = 0; j < m; j++) {
			a[i][j] = rand() % 25;
			cout << setw(3) << a[i][j] << ' ';
		}
		cout << endl;
	}
	int max = 0, ti = 0, tj = 0;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			if (max < a[i][j]) {
				max = a[i][j];
				ti = i;
				tj = j;
			}
		}
	}
	int sum = 0;
	for (int j = 0; j < m; j++) {
		sum += a[ti][j];
	}
	for (int i = 0; i < n; i++) {
		sum += a[i][tj];
	}
	sum -= a[ti][tj];
	a[ti][tj] = sum;
	cout << "Выводим измененную матрицу" << endl;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cout << setw(3) << a[i][j] << ' ';
		}
		cout << endl;
	}
	system("pause");
}