#include <iostream>

using namespace std;

int main()
{
    int sisi,alas,tinggi,sisi_t,bujur_sangkar,segitiga,trapesium;
    cout << "Masukkan Sisi : ";
    cin >> sisi;
    cout << "Masukkan Alas : ";
    cin >> alas;
    cout << "Masukkan Tinggi : ";
    cin >> tinggi;
    cout << "Masukkan Sisi Atas Trapesium : ";
    cin >> sisi_t;

    bujur_sangkar = sisi*sisi;
    segitiga = (alas*tinggi)/2;
    trapesium = ((alas+sisi_t)*tinggi)/2;
    cout << "Luas Bujur Sangkar : " << bujur_sangkar << endl;
    cout << "Luas Segitiga : " << segitiga << endl;
    cout << "Luas Trapesium adalah : " << trapesium << endl;
}