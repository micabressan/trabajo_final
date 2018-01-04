#include <fstream>
#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;
void Rikiuoti (double M[], int n);

int main()
{
    int n, k,  z=0, l=0;
    string iv, vard[100];
    double sv[100],paz[1000], vertinimas[100]={0}, kv[100];
    ifstream duota ("duota.txt");
    ofstream rez("rezultatai.txt");
    duota >> n >> k;
    const int pr = k;

    for(int i = 0; i < k ; i++)
            duota >> sv[i]; //nuskaitomi pazymio koeficientai
     duota.ignore(80,'\n');


    for(int i = 0; i < n; i++)
    {
        getline(duota, iv); //nuskaitomas vardas pavarde
        vard[i] = iv;
            for(int j = z; j < k ; j++)
               {
                   duota >> paz[j]; //ivedamai k pazymiu

                   //cout << paz[i] << endl;
               }
        z+= pr;
        k+=pr;
        int a=0;
        a =  iv.length();
        duota.ignore(a,'\n');
    }
    z=0;
    k=pr;
    for(int i = 0; i < n; i++)
    {
        for(int j = z; j < k; j++)
        {
             vertinimas[i] += paz[j] * sv[l]; //skaiciuoju kiekvieno zmogaus vertinima
             //cout << paz[j] << " " << j<<endl;
             l++;
        }
        l=0;
        z+=pr;
        k+=pr;
    }

    for(int i = 0; i < n; i++)
        kv[i] = vertinimas[i]; //sulyginu kad veliau galeciau rasti kam priklauso didziausias balas

    Rikiuoti(kv, n);
    double didz=0;
    int ats, kiek[12]={0};
    // for(int i = 0; i < n; i++)
       // cout << kv[i] << endl;
    didz = kv[0]; //didziausias balas

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            if(kv[i] == vertinimas[j]) //jei atitinka didziausia bala spausdina:
            {
                rez << vard[j]<< endl;
                paz[j] = (vertinimas[j]/didz) *10;
                ats = round(paz[j]);
                rez << fixed << setprecision(1)<<vertinimas[j] << " " <<setprecision(0) << ats << endl;
                kiek[ats]++;
            }


        }
    }
    rez << endl;
    for(int i = 10; i >= 1; i--)
    {
        if(kiek[i]!=0)
        {
            rez << i << " - " << kiek[i] << endl; //skaiciuojamas gautu pazymiu kiekis