#include "stdafx.h"
#include <iostream>
#include <string.h>
#include <string>
#include <windows.h>
using namespace std;

int main()
{
	char TheWord[100];
	cin.getline(TheWord, 100);
	char Except[50][50] = { 0 };
	OemToAnsi(TheWord, TheWord);
	int l = strlen(TheWord);
	int i = 0;
	int n = 0;
	int g = 0;
	int pos = 0;
	while (i < l)
	{
		while (TheWord[i] != ' ' && TheWord[i] != '\0')
		{
			i++;
			n++;
		}
		g++;
		int p = 1;
		bool b;
		while (p < n / 2 + 1)
		{
			for (int j = 0; j < n - p; j++)
			{
				if (TheWord[pos + j] == TheWord[pos + j + p])
				{
					b = true;
				}
				else
				{
					b = false;
					break;
				}
			}
			if (b)
			{
				break;
			}
			else
			{
				p++;
			}
		}
		if (b)
		{
			n = 0;
			i++;
			pos = i;
		}
		else
		{
			for (int m = 0; m < g - 1; m++)
			{
				for (int k = 0; k < n; k++)
				{
					if (TheWord[pos + k] == Except[m][k])
					{
						b = true;
					}
					else
					{
						b = false;
						break;
					}
				}
				if (Except[m][n] != 0)
				{
					b = false;
				}
				if (b)
				{
					break;
				}
			}
			if (b)
			{
				n = 0;
				i++;
				pos = i;
			}
			else
			{
				int h = 0;
				while (Except[h][0] != 0)
				{
					h++;
				}
				for (int k = 0; k < n; k++)
				{
					Except[h][k] = TheWord[pos + k];
					cout << TheWord[pos + k];
				}
				cout << " ";
				n = 0;
				i++;
				pos = i;
			}
		}
	}
	cout << endl;
	return 0;
}