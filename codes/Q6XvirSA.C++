
#include "stdafx.h"
#include <iostream>
#include <string>
#include <fstream>
#include <cctype>
#include <cstdlib>
#include <Windows.h>
#include <iomanip>


//#include "Nullstr.h"
#include "PrintMenu.h"
#include "Nalog.h"



using namespace std;
#define Asize 100

//struct Car
//{
//	string brand;
//	int year;
//	int power;
//	int mileage;
//};
//




Car* Add_Struct(Car* Obj, int quantity); //создание структуры
Car* Reading_File(Car* Obj); //считывание с файла
int Size_Struct(Car* Obj); //размер структуры
bool Write_File( Car* Obj); //запись в файл
Car* End_Data(Car* Obj, int i); //конец данных
Car* Add_Data(Car* Obj); //добавление строки
Car* Delete_Data(Car* Obj, int number_delete); //удаление строки
void Result( Car* Obj); //вывод на экран
int Pr(char* char_num, int n);
bool Check(char* char_num, int n);

void Sort(Car* Obj, int sort); //сортировка
bool Sort_Data(Car* Obj, int sort, int i); //для сортировки данных
int Nullstr(const Car* Obj);


int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	char n[Asize] = { '0' };
	Car* cars = NULL;
	int menu = 0, menu2 = 0;
	cars = Reading_File(cars); //Считываем из файла
	int size = Size_Struct(cars) - 1, num = 0;

	do
	{
		PrintMenu(1);
		cin >> menu;
		switch (menu)
		{
		case 1: //Добавление
		{
			Result(cars);
			cars = Add_Data(cars);
			Result(cars);
			break;
		}

		case 2: //Удаление
		{
			Result(cars);

			cout << "Введите номер для удаления: ";
			cin >> num;
			size = Size_Struct(cars) - 1;
			while (num > size || num < 0)
			{
				cout << "Строки " << num << " не существует!";
				cin >> num;
			}

			cars = Delete_Data(cars, num);

			break;
		}
		case 3: //Сортировка
		{
			Result(cars);
			PrintMenu(2);
			cin >> menu2;
			switch (menu2)
			{
			case 1: //Марка
				Sort(cars, 1);
				break;
			case 2: //Год выпуска
				Sort(cars, 2);
				break;
			case 3: //Мощность двигателя
				Sort(cars, 3);
				break;
			case 4: //Пробег
				Sort(cars, 4);
				break;
			case 5: //Налог
				Sort(cars, 5);
				break;
			case 0: //Назад
				break;
			default:
				cout << "\aНеверный пункт меню!\n";
				break;
			}
			Result(cars);
			continue;

			break;
		}
		case 4: //Показать на экране
		{
			Result(cars);
			break;
		}
		case 5: //Запись в фаил
		{
			Result(cars);
			if (Write_File(cars))
				cout << "\nЗапись данных произведена успешно!\n\n";
			else
				cout << "\n\aНе удалось записать данные в файл!\n\n";
			break;
		}
		case 0:
		{
			break;
		}

		default:
			cout << "Такого варианта нет.\n";
		}

	} while (menu != 0);


	return 0;
}



Car* Add_Struct(Car* Obj, int quantity)
{
	if (quantity == 0)
	{
		Obj = new Car[1]; // первая структура
	}
	else
	{
		Car* tempObj = new Car[quantity + 1];

		for (int i = 0; i < quantity; i++)
		{
			tempObj[i] = Obj[i]; // копируем во временный объект
		}
		delete[] Obj;

		Obj = tempObj;
	}
	return Obj;
}

Car* Reading_File(Car* Obj)
{
	int i = 0, tmp = 0;
	char check[200];

	ifstream fin;
	fin.open("D:\\1.txt", ios_base::in);
	if (!fin.is_open()) // если файл не был открыт
	{
		cout << "\aОшибка при открытии файла!\n";
		return NULL;
	}
	else
	{
		int err_str = 0; // Номер строки с ошибкой
		while (true)
		{
			Obj = Add_Struct(Obj, i);
			++err_str;

			fin >> Obj[i].brand;
			if (fin.eof())
				break;
			//марка машины
			Obj[i].brand = Obj[i].brand.substr(0, 14);
			//год выпуска
			fin >> check;
			if (Check(check, 1) == false)
			{
				cout << "ошибка при чтении " << err_str << "-й строки!\n";
				for (; fin.get() != '\n';)
					; // переход на следующую строку
				continue;
			}

			tmp = atof(check);
			Obj[i].year = tmp;

			////мощность
			fin >> check;
			if (Check(check, 1) == false)
			{
				cout << "ошибка при чтении " << err_str << "-й строки!\n";
				for (; fin.get() != '\n';)
					; // переход на следующую строку
				continue;
			}
			tmp = atof(check);
			Obj[i].power = tmp;


			////пробег
			fin >> check;
			if (Check(check, 2) == false)
			{
				cout << "ошибка при чтении " << err_str << "-й строки!\n";
				for (; fin.get() != '\n';)
					; //на следующую строку
				continue;
			}

			tmp = atof(check);
			Obj[i].mileage = tmp;

			++i;
		}

		Obj = End_Data(Obj, i);

		fin.close();

		return Obj;
	}
	return NULL;
}

int Size_Struct(Car* Obj)
{
	int с = 0;
	int n = Nullstr(Obj);
	for (int i = 0; i<n; i++)

	{
		с++;
	}

	return с;
}

bool Check(char* char_num, int n)
{
	if (n == 1)
	{
		if (char_num[0] == '0')
		{
			return false;
		}
		else
		{
			int i = 0;
			while (char_num[i] != '\0')
			{
				if (char_num[i] < '0' || char_num[i] > '9')
					return false;
				i++;
			}
			return true;
		}
	}
	if (n == 2)
	{
		int i = 0;
		while (char_num[i] != '\0')
		{
			if (char_num[i] < '0' || char_num[i] > '9')
				return false;
			i++;
		}
		return true;

	}
}

int Pr(char* char_num, int n)
{
	int N = 0;
	if (n == 1)
	{
		while (Check(char_num, 1) == false)
		{
			cout << "Введите подходящее значение\n";
			cin >> char_num;
		}
		N = atof(char_num);
	}
	if (n == 2)
	{
		while (Check(char_num, 2) == false)
		{
			cout << "Введите подходящее значение\n";
			cin >> char_num;
		}
		N = atof(char_num);
	}
	return N;
}

Car* End_Data(Car* Obj, int i)
{
	Obj = Add_Struct(Obj, i);

	Obj[i].brand = '0';
	Obj[i].year = 0;
	Obj[i].power = 0;
	Obj[i].mileage = 0;

	return Obj;
}

int Nullstr(const Car* Obj)
{
	int n = 0;
	int i = 0;
	while (true)
	{
		if ((Obj[i].brand == "0") && (Obj[i].year == 0) && (Obj[i].power == 0) && (Obj[i].mileage == 0))
		{
			n = i;
			break;
		}
		i++;
	}
	return n;
}

void Result( Car* Obj)
{
	cout << "№ Марка машины          Год выпуска    Мощность двигателя       Пробег      Размер "
		"налога\n";
	int n = Nullstr(Obj);
	for (int i = 0; i<n; i++)
	{
		cout << i << "  ";
		cout << setw(10) << left;
		cout << Obj[i].brand << "\t\t";

		cout << Obj[i].year << " год\t\t";

		cout << Obj[i].power << " л.с\t\t";

		cout << Obj[i].mileage << "км\t\t  ";

		cout << (Nalog(Obj, i)) << "р\t\t  ";
		cout << "\n\n";
	}
}

Car* Add_Data(Car* Obj)
{
	int size = Size_Struct(Obj);
	int tmp = 0;
	char check[100];

	//Марка
	cout << "Марка: ";
	cin >> Obj[size].brand;
	Obj[size].brand = Obj[size].brand.substr(0, 14);
	//Год выпуска
	cout << "Год выпуска: ";
	cin >> check;
	tmp = Pr(check, 1);
	Obj[size].year = tmp;
	//мощность
	cout << "мощность: ";
	cin >> check;
	tmp = Pr(check, 1);
	Obj[size].power = tmp;
	//пробег
	cout << "пробег: ";
	cin >> check;
	tmp = Pr(check, 2);
	Obj[size].mileage = tmp;
	Obj = End_Data(Obj, size + 1);

	return Obj;
}

Car* Delete_Data(Car* Obj, int number_delete)
{
	int size = Size_Struct(Obj);
	--size;

	Car* tempObj = new Car[size];

	for (int j = 0; j < number_delete; j++)
	{
		tempObj[j] = Obj[j];
	}

	for (int j = number_delete; j < size; j++)
	{
		tempObj[j] = Obj[j + 1];
	}
	delete[] Obj;

	tempObj = End_Data(tempObj, size);

	return tempObj;
}

bool Write_File( Car* Obj)
{
	ofstream fout;
	fout.open("D:\\2.txt", ios_base::out | ios_base::trunc);
	if (!fout.is_open()) //если файл не был открыт
	{
		cout << "\aОшибка при записи данных!\n";
		return false;
	}
	else
	{
		int n = Nullstr(Obj);
		for (int i = 0; i<n; i++)
		{

			fout << setw(10) << left;
			fout << Obj[i].brand << "\t\t";

			fout << Obj[i].year << " год\t\t";

			fout << Obj[i].power << " л.с\t\t";

			fout << Obj[i].mileage << "км\t\t  ";

			fout << (Nalog(Obj, i)) << "р\t\t  ";
			fout << "\n\n";
		}
		fout.close();
	}
	return true;
}



void Sort(Car* Obj, int sort)
{
	Car tmp;
	bool flag = true;

	while (flag)
	{
		flag = false;
		int n = Nullstr(Obj);
		for (int i = 0; i<n - 1; i++)
		{
			if (Sort_Data(Obj, sort, i))
			{
				flag = true;
				tmp = Obj[i];
				Obj[i] = Obj[i + 1];
				Obj[i + 1] = tmp;
			}
		}
	}
}

bool Sort_Data(Car* Obj, int sort, int i)
{
	//Марка
	if (sort == 1)
	{
		string brand1 = Obj[i].brand;
		string brand2 = Obj[i + 1].brand;

		return brand1 > brand2;
	}
	//Год выпуска
	if (sort == 2)
	{
		int year1 = Obj[i].year, year2 = Obj[i + 1].year;

		return year1 < year2;
	}
	//Мощность двигателя
	if (sort == 3)
	{
		int power1 = Obj[i].power, power2 = Obj[i + 1].power;

		return power1 < power2;
	}
	//Пробег
	if (sort == 4)
	{
		int mileage1 = Obj[i].mileage, mileage2 = Obj[i + 1].mileage;

		return mileage1 < mileage2;
	}
	//Налог
	if (sort == 5)
	{
		int nalog1 = (Nalog(Obj, i)), nalog2 = (Nalog(Obj, i + 1));
		return nalog1 < nalog2;
	}
	return NULL;
}