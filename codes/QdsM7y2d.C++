#include<iostream>
#include<iomanip>
#include<conio.h>
using namespace std;
double abs(double x)
{
    if (x < 0) return -x;
    return x;
}
void wyswietl_macierz(double **(& tab),int wiersz, int kolumna);
double wyznacznik(double **&, int);
void wpisz_do_macierzy(double **(& tab),int wiersz, int kolumna);
void wyznacznik(double **(& tab),int wiersz, int kolumna);
void przeciwne_znaki(double &x)
{
    double zig = -x;
    x = zig;
}
void swap_(double &x, double &y)
{
    double zig;
    zig = x;
    x = y;
    y = zig;
}
void powitanie()
{
    cout << "Hello World!\n";
    getch();
}
double wyznacznik (double ** (&tab), int wiersz)
{
    double det = 1;
    for (int i = 0;i<wiersz;i++)
    {
        det *= tab[i][i];
    }
    return det;
}
void szukajka(double **(& tab),int krok, int wiersz, int kolumna)
{
    for (int i = 0; i < wiersz; i++)
    {
            if (tab[i][krok-1] == -1) {
                for (int z = 0;z < kolumna;z++){
                    przeciwne_znaki(tab[i][z]);
                }
            }
            if (tab[i][krok-1] == 1) {
                for (int z = 0;z < kolumna;z++){
                    swap_(tab[i][z],tab[krok-1][z]);
                }
                cout << "\nznalazlem\tcord: " << i << "," << krok-1 << endl;
                break;
            }

    }
}
void eliminuj_pozostale(double **(& tab), int krok, int wiersz, int kolumna)
{
    double coe;
for (int i = 0; i < wiersz; i++)
    {

        if (krok-1==i){

        }
        else {
            coe = -(tab[i][krok-1])/(tab[krok-1][krok-1]);
       //     cout << "coe: " << coe << endl;
            for (int z = 0; z < kolumna;z++){
                tab[i][z]+=coe*tab[krok-1][z];
                if (abs(tab[i][z]) < 1e-12 ) {
                    tab[i][z]=0;
                }////
            }
        }
    }
}
void eliminacja_gaussa(double **(& tab),int kolumna, int wiersz)
{
    // szukajka
    int limit=wiersz;
    if (wiersz>kolumna){
        limit = kolumna;
    }
    for (int k = 1;k<=kolumna;k++)
    {
      //  szukajka(tab,k,wiersz,kolumna);
       eliminuj_pozostale(tab,k,wiersz,kolumna);
    //  wyswietl_macierz(tab,wiersz, kolumna);
      getch();
    }
    double det;
    det = wyznacznik(tab,wiersz);
    cout << "Wyznacznik: " << det << endl;

}
void wyswietl_macierz(double **(& tab),int wiersz, int kolumna)
{

    for (int i = 0;i < kolumna;i++)
    {
        for (int j = 0;j < wiersz;j++)
        {
            cout << tab[i][j] << "\t";
        }
        cout << endl;
    }
}
void pobranie_danych()
{
   // cout << setprecision(5);
    cout << "Podaj rozmiar macierzy " << endl;
    int rozmiar_x,rozmiar_y;
    cout << "Ilosc wierszy:" << endl;
    cin >> rozmiar_x;
    cout << "Ilosc kolumn:" << endl;
    cin >> rozmiar_y;
    double** macierz = new double *[rozmiar_x];
    cout << "Wpisz kaskadowo wierze: " << endl;
    for (int i = 0; i < rozmiar_x;i++)
    {
        macierz[i] = new double [rozmiar_y];
        for (int j = 0; j < rozmiar_y; j++)
        {
            cin >> macierz[i][j];
        }
    }
    double **macierz_wsk=macierz;
    wyswietl_macierz(macierz_wsk,rozmiar_y, rozmiar_x);

    getch();
    eliminacja_gaussa(macierz_wsk,rozmiar_x,rozmiar_y);
}

int main()
{
   // powitanie();
    pobranie_danych();
    return 0;
}