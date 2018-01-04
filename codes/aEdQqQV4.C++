#include <iostream>
#include <string>
#include <fstream>
#include <cctype>
#include <cstdio>

using namespace std;

int main()
{
	string line;
	int i = 0;
	ifstream fin("Input.txt");
	ofstream fout("Output.txt");
	fin >> line;
	fin.close();
	for (; isupper(line[i]) && line[i] != ' '; ++i)
	{
		if (isupper(line[i]) && line[i] != ' ')
		{
			fout << "No";
			fout.close();
			exit(0);
		}
		for (int a = 0; !isupper(line[i]) && a <= 3 & line[i] != ' '; ++a)
		{
			i++;
		}
	}
	fout << "Yes";
	fout.close();
	system("pause");
}