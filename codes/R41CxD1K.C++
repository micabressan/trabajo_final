 #include <iostream>
#include "naglowki.h"
#include <windows.h>
#include <conio.h>
 
using namespace std;
 
void Bankomat::pokaz()
{
    char wybor;
 
    while(true)
    {
        system("cls");
        cout << "Witaj w banku!" << endl << endl;
 
        cout << "1. Zaloguj" << endl;
        cout << "2. Zarejestruj" << endl << endl;
 
        cout << "Wybor: ";
        wybor = getch();
 
        switch(wybor)
        {
        case '1':
            {
                zaloguj();
                break;
            }
        case '2':
            {
                zarejestruj();
                break;
            }
        default:
            {
                system("cls");
                cout << "Podaj cyfre '1' lub '2'!";
                Sleep(2000);
            }
        }
    }
}