#include "stdafx.h"
#include "cmath"
#include <iostream>
using namespace std;

int main()
{
	char str1[255], str2[255];
	int num = -1;
	bool found = false;

	cout << "Enter first string" << endl;
	cin.get (str1, 255);
	cout << "Enter second string" << endl;
	cin.get (str2, 255);
	while (str2)
		for (int i=0; i<255; i++)
			if (str1[i]==str2[0])
			{
				num = i;
				found = true;
				int k = 0;
				while (found && str2)
					if (str1[i] == str2[k])
					{
						k++;
						i++;
					}
					else
					{
						found = false;
						num = -1;
					}
			}

	cout << num << endl;

	system("pause");
	return 0;
}