#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
using namespace std;

int main()
{
	cout << "Dawid Szwajkowski" << endl;
	fstream plik1, plik2, plik3, plik4;
	string pierwszy, drugi, trzeci, czwarty;
	plik1.open("plik1.txt", ios::in);
	if (plik1.good() == false)
	{
		cout << "Nie mozna otworzyc pliku plik1.txt" << endl;
		system("pause");
	}
	plik2.open("plik2.txt", ios::in);
    if (plik2.good() == false)
	{
		cout << "Nie mozna otworzyc pliku plik2.txt" << endl;
		system("pause");
	}
	plik3.open("plik3.txt", ios::in);
    if (plik3.good() == false)
	{
		cout << "Nie mozna otworzyc pliku plik3.txt" << endl;
		system("pause");
	}
    getline(plik1, pierwszy);
    getline(plik2, drugi);
    getline(plik3, trzeci);
    czwarty += pierwszy;
    czwarty += drugi;
    czwarty += trzeci;
    plik4.open("plik4.txt", ios::out);
    plik4 << czwarty;
	plik1.close();
	plik2.close();
	plik3.close();
	plik4.close();
    return 0;
}