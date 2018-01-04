#include <iostream> //negacja,koniunkcja, alternatywa, suma modulo, ktory bit  zanegowac,

using namespace std;

void zeruj_tablice(int *tab, int *tab2)
{
    for (int i = 0; i < 8; i++)
    {
        tab[i] = 0;
        tab2[i] = 0;
    }
}

void wyswietl(int *tab)
{
    int i = 0;

    while(i < 8)
    {
        cout << tab[i] << " ";
        i++;
    }

}

void zamien_binarnie(int liczba, int *tab)
{
    int a = 7;
    int b = 0;

    while(a != 0)
    {
        b = liczba%2;
        tab[a] = b;
        a--;
        liczba = liczba / 2;
    }
}

void negacja(int liczba, int *tab)
{
    zamien_binarnie(liczba, tab);

    int i = 0;

    while(i < 8)
    {
        if(tab[i] == 1)
        {
            tab[i] = 0;
        }
        else
        {
            tab[i] = 1;
        }
        i++;
    }
}

void koniunkcja(int liczba, int liczba2, int *tab, int *tab2)
{
    zeruj_tablice(tab, tab2);
    zamien_binarnie(liczba,tab);
    zamien_binarnie(liczba2, tab2);

    int i = 0;

    while(i < 8)
    {
        if (tab[i] == 1 && tab2[i] == 1)
        {
            tab[i] = 1;
        }
        else
        {
            tab[i] = 0;
        }
        i++;
    }
}

void alternatywa(int liczba, int liczba2, int *tab, int *tab2)
{
    zeruj_tablice(tab, tab2);
    zamien_binarnie(liczba, tab);
    zamien_binarnie(liczba2, tab2);

    int i = 0;

    while(i < 8)
    {
        if (tab[i] == 0 && tab2[i] == 0)
        {
            tab[i] = 0;
        }
        else
        {
            tab[i] = 1;
        }
        i++;
    }
}

void modulo(int liczba, int liczba2, int *tab, int *tab2)
{
    zeruj_tablice(tab, tab2);
    zamien_binarnie(liczba, tab);
    zamien_binarnie(liczba2, tab2);

    int i = 0;

    while(i < 8)
    {
        if ((tab[i] == 1 && tab2[i] == 1) || (tab[i] == 0 && tab2[i] == 0))
        {
            tab[i] = 0;
        }
        else
        {
            tab[i] = 1;
        }
        i++;
    }
}

void reczna_negacja(int liczba, int negowany_bit, int *tab)
{
    int indeks_bitowy;
    zamien_binarnie(liczba, tab);

    indeks_bitowy = negowany_bit;
    if(tab[indeks_bitowy] == 1)
    {
        tab[indeks_bitowy] = 0;
    }
    if(tab[indeks_bitowy] == 0)
    {
        tab[indeks_bitowy] = 1;
    }
}

int main() {
    int liczba,liczba2;
    int binarnie[8], binarnie2[8];

    cout << "Wprowadz pierwsza liczbe..." << endl;
    cin >> liczba;
    cout << "Wprowadz druga liczbe..." << endl;
    cin >> liczba2;

    zeruj_tablice(binarnie, binarnie2);

    cout << "Postac binarna pierwszej liczby" << endl;
    zamien_binarnie(liczba, binarnie);

    wyswietl(binarnie);

    cout << endl;

    zamien_binarnie(liczba2, binarnie2);
    cout << "Postac binarna drugiej liczby" << endl;

    wyswietl(binarnie2);

    cout << endl;

    cout << "Negacja pierwszej liczby:" << endl;
    negacja(liczba, binarnie);

    wyswietl(binarnie);

    cout << endl;

    cout << "Negacja drugiej liczby:" << endl;
    negacja(liczba2, binarnie2);

    wyswietl(binarnie2);

    cout << endl;

    cout << "Koniunkcja dwoch liczb binarnych to:" << endl;
    koniunkcja(liczba, liczba2, binarnie, binarnie2);

    wyswietl(binarnie);

    cout << endl;

    cout << "Alternatywa dwoch liczb binarnych to:" << endl;
    alternatywa(liczba, liczba2, binarnie, binarnie2);

    wyswietl(binarnie);

    cout << endl;

    cout << "Suma modulo dwoch liczba binarnych to:" << endl;
    modulo(liczba, liczba, binarnie, binarnie2);

    wyswietl(binarnie);

    cout << endl;

    int bit;
    cout << "Reczna negacja pierwszej tablicy.Ktory bit zanegowac?" << endl;
    cin >> bit;
    reczna_negacja(liczba, bit, binarnie);

    wyswietl(binarnie);

    cout << endl;

    cout << "Reczna negacja drugiej tablicy. Ktory bit zanegowac?" << endl;
    cin >> bit;
    reczna_negacja(liczba2, bit, binarnie2);

    wyswietl(binarnie2);
}