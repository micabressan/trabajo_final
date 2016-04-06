#include <math.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <conio.h>
using namespace std;

double proiz1(int n)
{
        int r = 1;
        for (int i = 0; i <= n; i++)
        {
                r *= abs(2 * i - 1);
        }
        return r;
}

double proiz2(int n)
{
        int r = 1;
        for (int i = 1; i <= n; i++)
        {
                r *= 2 * i;
        }
        return r;
}

double FInput()
{
	double x;
	ifstream Fin("D:\\DEV\\in.txt", ios::in);
	Fin >> x;
	Fin.close();
	return x;
}

double KInput()
{
	double x;
	cout << "Input  x: ";
	cin >> x;
	return x;
}

void FOutput(double y, double yn)
{
	ofstream Fout("D:\\DEV\\out.txt", ios::out);
	Fout << "Summ " << y << ", Yn " << yn << "\n";
	Fout.close();
}

void SOutput(double y, double yn)
{
	cout << "Summ " << y << ", Yn " << yn << "\n";
}

double Input1()
{
	int t;
	double x = 0;

	cout << "Select input mode:\n" << "1 - file\n" << "2 - keyboard\n";
	do
	{
		cin >> t;
		switch (t)
		{
		case 1:
		{
			x = FInput();
			break;
		}
		case 2:
		{
			x = KInput();
			break;
		}
		default:
		{
			cout << "Input 1 or 2 for select input mode, Q for exit.\n";
		}
		}
	} while (_kbhit() && _getch() == 81);
	return x;
}

void Output1(double x)
{
	cout << "Select output mode:\n" << "1 - file\n" << "2 - screen\n";
	do
	{
		double E = 0.001;
		double y = 0;
		double yn = 1;
		int n = 0;
		int t;

		cin >> t;
		switch (t)
		{
		case 1:
		{
			ofstream Fout("D:\\DEV\\out.txt", ios::out);
			for (n = 0; abs(yn) >= E; n++)
			{
				yn = (proiz1(n) / proiz2(n)) * pow(x, n);
				y += yn;
				Fout << "Summ " << y << ", Yn " << yn << "\n";
			}
			Fout.close();
			break;
		}
		case 2:
		{
			for (n = 0; abs(yn) >= E; n++)
			{
				yn = (proiz1(n) / proiz2(n)) * pow(x, n);
				y += yn;
				cout << "Summ " << y << ", Yn " << yn << "\n";
			}
			break;
		}
		default:
		{
			cout << "Input 1 or 2 for select input mode, Q for exit.\n";
		}
		}
	} while (_kbhit() && _getch() == 81);
}
void main()
{		
	int N;
	int M;

	cout << "Enter N, M: \n";
	cin >> N >> M; // получение от пользователя размера массива
	double *X = new double[N];
	double **Y = new double*[N];
	for (int i = 0; i < X; i++) Y[i] = new int[M];

	Input1();
	Output1(Input1());
		
	system("pause");
}