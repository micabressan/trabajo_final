#include <iostream>
 
using namespace std;
 
class Bankomat
{
    int PIN_do_rejestracji, ilosc_klientow;
    int *PINy, *StanyKont;
 
public:
    void pokaz();
    void zaloguj();
    void zarejestruj();
    void proceslogowania();
    void procesrejestracji();
    void wczytajiloscklientow();
    void zapisziloscklientow();
};