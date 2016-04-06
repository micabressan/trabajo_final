#include <iostream>
#include "naglowki.h"
#include <windows.h>
#include <sstream>
#include <stdio.h>
 
using namespace std;
 
void Bankomat::zaloguj()
{
    int PIN;
 
    while(true)
    {
        system("cls");
 
        cout << "\t" << "LOGOWANIE" << endl << endl;
        cout << "Podaj PIN: ";
 
        if(!(cin>>PIN))
        {
            system("cls");
            cout << "Podaj czterocyfrowy PIN!";
            cin.clear();
            cin.sync();
            Sleep(2000);
        }
        else
        {
            int dlugosc;
            ostringstream ss;
 
            ss << PIN;
            string PINstring = ss.str();
            dlugosc = PINstring.length();
            ss.str("");
 
            if((dlugosc > 4) || (dlugosc < 4))
            {
                system("cls");
                cout << "PIN posiada 4 cyfry!";
                cin.clear();
                cin.sync();
                Sleep(2000);
            }
            else
            {
                system("cls");
                proceslogowania();
                break;
            }
        }
    }
}
 
void Bankomat::zarejestruj()
{
    while(true)
    {
        system("cls");
 
        cout << "\t" << "REJESTRACJA" << endl << endl;
        cout << "Podaj PIN do rejestracji: ";
 
        if(!(cin>>PIN_do_rejestracji))
        {
            system("cls");
            cout << "Podaj czterocyfrowy PIN!";
            cin.clear();
            cin.sync();
            Sleep(2000);
        }
        else
        {
            int dlugosc;
            ostringstream ss;
 
            ss << PIN_do_rejestracji;
            string PINstring = ss.str();
            dlugosc = PINstring.length();
            ss.str("");
 
            if((dlugosc > 4) || (dlugosc < 4))
            {
                system("cls");
                cout << "PIN posiada 4 cyfry!";
                cin.clear();
                cin.sync();
                Sleep(2000);
            }
            else
            {
                system("cls");
                procesrejestracji();
                break;
            }
        }
    }
}