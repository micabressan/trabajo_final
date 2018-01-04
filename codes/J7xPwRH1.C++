#include <cstdio>
#include <iostream>
#include <vector>
#include <cassert>
using namespace std;

int main()
{
    int Z; //l.zestawów
    //int key; //szukana - muszę znaleźć jej indeks w tablicy w kazdym zestawie
    //int ilosc_key; // WYNIK DO COUT
        
    int t[1000000]; // 1 zestaw zysków
    int tt[1000000];

    
    cin >> Z;
    for(int i=0;i<Z;i++)
    {
        int b = 0; //pierwszy element tablicy
        int c = 0;
        int n; // liczba zeznań - liczba elementów w tablicy
        cin >> n;
        int m = n;
        int e = n - 1; //ostatni element tablicy
        int f = m - 1;
        int zeznanie; //pomocnicza - niemalejąco zyski
        for(int j=0;j<n;j++)
        {
            cin >> zeznanie;
            t[j] = zeznanie;// wpisuję zyski do jednej tablicy - w niej szukam key
            tt[j] = zeznanie;
        }
        
        
        int q; //liczba zapytań
        cin >> q;
        int key; //szukana - muszę znaleźć jej indeks w tablicy w kazdym zestawie
        for(int k=0;k<q;k++)
        {
            cin >> key;
            
            
            ///////////szukanie najniższego el. tablicy z key            
            while(e - b + 1 >= 2)//dopóki e>b (jest przynajmniej 1 element)
            {
                int s=(b+e)/2; // s to połowa
                if(t[s]<key)
                    b = s + 1; 
                else
                    e = s;
            }
            assert(b==e);
            if(t[b]==key)
                cout << "found " << b << endl; //miejsce 1. wystąpienia key 
            else
                cout << "not found" << endl;
            int x = b; //x - indeks 1. wystąpienia key
            b = 0;
            



            ///////////szukanie najwyższego el. tablicy z key
            while(f - c + 1 >= 2)//dopóki f>c (jest przynajmniej 1 element)
            {
                int r=(c+f+1)/2; // r to połowa
                if(tt[r]<=key)
                    c = r;
                else
                    f = r-1;
            }            
            assert(c==f);
            int z = c; //z - indeks ostatniego wystąpienia key
            if(tt[c]==key)
                cout << "found " << c << endl; //miejsce osattniego wystąpienia key 
            else
                cout << "not found" << endl;            


        
            /*
            ///////////szukanie najwyższego el. tablicy z key
            while(e - b + 1 >= 2)//dopóki e>b (jest przynajmniej 1 element)
            {
                int s=(b+e+1)/2; // s to połowa
                if(t[s]<=key)
                    b = s
                else
                    e = s-1;
            }            
            assert(b==e);
            int z = b; //z - indeks ostatniego wystąpienia key
            if(t[b]==key)
                cout << "found " << b << endl; //miejsce osattniego wystąpienia key 
            else
                cout << "not found" << endl;
                        
            b = 0;
            */
            
        }
        for(int g=0;g<n;g++)
            t[g]='/0';
        for(int h=0;h<n;h++)
            tt[h]='/0'; 
    }
}