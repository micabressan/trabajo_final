// если компилятор visual studio 2012 и выше 
//#include "stdafx.h"
//#pragma warning(disable:4996)

#include <stdio.h>  // для ввода-вывода , файловый операций
#include <locale.h> // для отображения русских букв на консоли 
#include <string.h> // для strstr
#include <conio.h>  // для getch()
#include <stdlib.h> // exit()

int main(int argc, char ** argv)
{
	setlocale(0,"Rus");
	
	if(argc < 2)
	{
		printf("Отсутствуют параметры командной строки\n");
		getch();
		exit(-1);
	}

	printf("\nПараметры командной строки %s %s", argv[1], argv[2]);

	FILE *f1 = fopen(argv[2], "r");

	if(!f1)
	{
		printf("\nНе удалось открыть файл!\n");
		getch();
		exit(-1);
	}
	// максимальное количество строк 256 по 256 символов, можно увеличить за необходимости
	char all_String_in_file[256][256];
	int i = 0, j = 0; // i - j  для индексов
	char text[256];                  // для считования текста из файлa

	int kol_strok_f1 = 0;

	
	for(; !feof(f1); ) // пока не конец файла читаем данные 
	{
		    fgets(text,sizeof(text),f1); // читаем строку 
			strcpy(all_String_in_file[kol_strok_f1++], text);	
	}

	kol_strok_f1--;
	printf("\n\nСодержимое файла \n\n");
	for(int i = 0; i < kol_strok_f1; i++)
		printf("%s",all_String_in_file[i]);


	printf("\n\nНайденные строки\n");
	for(i = 0; i < kol_strok_f1;  i++)     // проходим по острокам, пока не пройдём все строки файла
		if(strstr(all_String_in_file[i], argv[1]) != NULL) // функция strstr делает поиск подстроки в строке, если строка есть выводим на экран
		{ 
			printf("%s",all_String_in_file[i]); 					
		}
// закрываем файл
	fclose(f1);
	
	getch(); // задержка окна
	return 0;
}