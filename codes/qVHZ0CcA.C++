#include <iostream>
#include "naglowki.h"
#include <fstream>
#include <windows.h>
 
using namespace std;
 
void Bankomat::proceslogowania()
{
    fstream plik;
 
    wczytajiloscklientow();
 
    PINy = new int[ilosc_klientow];
    StanyKont = new int[ilosc_klientow];
 
    plik.open("uzytkownicy.txt", ios::in);
    if(plik.good() == false)
    {
        system("cls");
        cout << "Blad polaczenia z baza danych!";
        Sleep(2000);
    }
    else
    {
        int nr_linii = 1;
        string linia;
        int licznik = 0;
 
        while(getline(plik, linia))
        {
            switch(nr_linii)
            {
            case 1:
                {
                    PINy[licznik] = atoi(linia.c_str());
                    licznik++;
                }
            }
            if(nr_linii == 2)
            {
                nr_linii = 0;
            }
            nr_linii++;
        }
        plik.clear();
        plik.close();
 
        plik.open("uzytkownicy.txt", ios::in);
        if(plik.good() == false)
        {
            system("cls");
            cout << "Blad polaczenia z baza danych!";
            Sleep(2000);
        }
        else
        {
            int nr_linii2 = 1;
            string linia2;
            int licznik2 = 0;
 
            while(getline(plik, linia2))
            {
                switch(nr_linii2)
                {
                case 2:
                    {
                        StanyKont[licznik2] = atoi(linia2.c_str());
                        licznik2++;
                    }
                }
                if(nr_linii2 == 2)
                {
                    nr_linii2 = 0;
                }
                nr_linii2++;
            }
            plik.clear();
            plik.close();
        }
    }
}
 
void Bankomat::procesrejestracji()
{
    fstream plik;
 
    wczytajiloscklientow();
 
    plik.open("uzytkownicy.txt", ios::out | ios::app);
    if(plik.good() == false)
    {
        system("cls");
        cout << "Blad polaczenia z baza danych!";
        Sleep(2000);
    }
    else
    {
        int PoczatkowyStanKonta = 0;
 
        plik << PIN_do_rejestracji << endl;
        plik << PoczatkowyStanKonta << endl;
 
        ilosc_klientow++;
    }
    plik.close();
 
    zapisziloscklientow();
}