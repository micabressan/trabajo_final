#include <iostream>
#include <fstream>
#include <string>

int main()
{
    std::ifstream plik;
    plik.open ("C:/test.txt");
    std::string litery;

       
       plik.seekg(2);
       std::getline(plik, litery);
       plik.seekg(5);
       std::getline(plik, litery);
       plik.seekg(8);
       std::getline(plik, litery);

       std::cout << litery;



    return 0;
}