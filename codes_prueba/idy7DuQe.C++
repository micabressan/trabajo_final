
#include <iostream>
#include <iomanip>
#include <cstdlib>




using namespace std;

void bankomat(){
     int pin = 1234; // jakis tam
     int licznik = 0;
     int podanyPIN;
     bool poprawny = false;
     do{
        cout<<"podaj pin";
        cin >> podanyPIN;
        if(podanyPIN == pin){
             poprawny = true;             
        }
        licznik++;
     }while(licznik != 3 && poprawny == false);
     if(pin==podanyPIN){
          //cos tu powinno pisac
     }
}

int przelicz(int a, int b){
    return a*b; 
}     

void konwerter(){
     int jednostka, przelicznik;
     cout << "Podaj jednostkę, jaką chcesz przeliczyć - "; 
     cin >> jednostka;
     cout << endl << "Podaj przelicznik, jaki chcesz zastosować - "; 
     cin >> przelicznik;
     int wynik = przelicz(jednostka, przelicznik);   
     cout << "Wynik to: " << wynik << endl << endl;  
}




int main(){
    int menu;
    cout << setprecision(1000);//wyznaczenie dokładności kalkulatora (usunięcie notacji wykładniczej)
      cout << "Witaj, co chciałbyś dziś zrobić?";
     do{     
       
        cout << endl <<"Wolisz przeliczać jednostki czy sprawdzić stan konta? \nWybierz opcję nr 1.(przeliczanie jednostek) lub opcję nr 2. (sprawdzenie stanu konta). Inna wartosc wylaczy program";
        cout << endl << "1     //     2"<< endl;
        cin >> menu;
        
        switch (menu){
               case 1:
                    konwerter();
                    break;
               case 2:
                    bankomat();
                    break;     
               }
    
    }while(menu == 1 || menu == 2);
    
    cout << "koniec";
}