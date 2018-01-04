#include "stdafx.h"
#include "cmath"
#include <iostream>
#include <time.h>
using namespace std;

bool func()
{
}

int main()
{
	srand(time(NULL));

	int n, m;
	float S;

	cout << "Enter n and m" << endl;
	cin >> n >> m;
	cout << "Enter S" << endl;
	cin >> S;

	float **a = new float*[n];
	for (int i = 0; i < n; i++)
		a[i] = new float;
	for (int i = 0; i < n; i++)
		for (int j = 0; j < m; j++)
			a[i][j] = rand()%500;

	bool **b = new bool*[n];
	for (int i = 0; i < n; i++)
		b[i] = new bool;
	for (int i = 0; i < n; i++)
		for (int j = 0; j < m; j++)
			b[i][j] = false;

	for (int i = 0; i<n; i++)
		for (int j = 0; j<m; j++)
			if ((i == 0) || (i == n - 1) || (j == 0) || (j == (m - 1)))
			{
				if ((i == 0) && (j == 0)) { if ((a[i + 1][j] + a[i][j + 1]) < S) b[i][j] = true; }
				else if ((i == 0) && (j == (m - 1))) { if ((a[i + 1][j] + a[i][j - 1]) < S) b[i][j] = true; }
				else if ((i == (n - 1)) && (j == 0)) { if ((a[i - 1][j] + a[i][j + 1]) < S) b[i][j] = true; }
				else if ((i == (n - 1)) && (j == (m - 1))) { if ((a[i - 1][j] + a[i][j - 1]) < S) b[i][j] = true; }
				else if (i == 0) { if ((a[i + 1][j] + a[i][j - 1] + a[i][j + 1]) < S) b[i][j] = true; }
				else if (j == 0) { if ((a[i - 1][j] + a[i + 1][j] + a[i][j + 1]) < S) b[i][j] = true; }
				else if (i == (n - 1)) { if ((a[i - 1][j] + a[i][j - 1] + a[i][j + 1]) < S) b[i][j] = true; }
				else if (j == (m - 1)) { if ((a[i - 1][j] + a[i][j - 1] + a[i + 1][j]) < S) b[i][j] = true; }
			}
			else

	cout << "Resulting array:" << endl;
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < m; j++)
			cout << b[i][j] << " ";
		cout << endl;

	system("pause");
	return 0;
}