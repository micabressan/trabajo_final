// ConsoleApplication2.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <string>
#include "windows.h"

using namespace std;
void main()
{
	int kol = 0;
	setlocale(LC_ALL, "Russian");
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	string str, str1, str2, str3;
	cout << "Введите строку" << endl;
	getline(cin, str);
	while (str.find(" а ") != string::npos) {
		str.replace(str.find(" а "), 3, ",а ");
		kol++;
	}
	while (str.find(" но ") != string::npos) {
		str.replace(str.find(" но "), 4, ",но ");
		kol++;
	}
	if (kol != 0) {
		kol++;
	}
	cout << str << endl;
	cout << "Количество подстрок = " << kol << endl;
	str = str + " ,";
	str1 = "";
	while (str.find(',') != string::npos) {
		str2 = str.substr(0, str.find(','));
		str = str.substr(str.find(',') + 1, str.length());
		str3 = str2.substr(0, str2.find(' '));
		if (str3.compare("а") == 0 || str3.compare("но") == 0) {
			str3 = str2.substr(str2.find(' ') + 1, str2.substr(str2.find(' ') + 1, str2.length()).find(' '));
		}
		str1 += str3 + ' ';
	}
	cout << "Строка, сформированная из первых слов подстрок :" << endl;
	cout << str1;
	system("pause");
}