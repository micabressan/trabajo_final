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
	fout.open("Output.txt");
	fin.open("Input.txt");
	fin >> line;
	fin.close();
	for (;isupper(line[i]) && line[i] != '\0'; ++i)
	{
		if (isupper(line[i]) && line[i] != '\0')
		{
			fout << "No";
			fout.close();
			exit(0);
		}
		for (int a = 0; !isupper(line[i]) && a <= 3 & line[i] != '\0'; a++)
		{
			i++;
		}
	}
	fout << "Yes";
	fout.close();
	system("pause");
}