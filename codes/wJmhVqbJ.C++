#include <iostream>

using namespace std;

int main()
{
    int pertama,kedua,tambah,kurang,bagi,kali;
    cout << "masukkan angka pertama : ";
    cin >> pertama;
    cout << "masukkan angka kedua : ";
    cin >> kedua;
    
    tambah = pertama + kedua;
    kurang = pertama - kedua;
    kali = pertama * kedua;
    bagi = pertama / kedua;
    
    cout << "Hasil pertambahan : " << tambah << endl;
    cout << "Hasil pengurangan : " << kurang << endl;
    cout << "Hasil perkalian : " << kali << endl;
    cout << "Hasil pembagian : " << bagi << endl;

}