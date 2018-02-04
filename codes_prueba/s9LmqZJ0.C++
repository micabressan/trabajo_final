#include<iostream>
#include<string>

using namespace std;

bool dodawanie(char *tab, char *wyraz1, char *wyraz2, char *wynik, bool przeniesienie, int poziom, int cyfra1, int cyfra2){
    /*for(int i=0; i<10; ++i){ //petla pomocnicza ktora wyswiietla stan tablicy
        cout<<tab[i]<<" ";
    }
    cout<<" |"<<endl;*/
    //wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
    for(int i=0; i<sizeof(wyraz1); ++i)
    {
        cout<<wyraz1[i];
    }
    cout<<endl;
    for(int i=0; i<sizeof(wyraz2); ++i)
    {
        cout<<wyraz2[i];
    }
    cout<<endl;
    for(int i=0; i<sizeof(wynik); ++i)
    {
        cout<<wynik[i];
    }//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
    cout<<endl;

    int linia=poziom%3; //ktora linia
    int ktory_znak=poziom/3;    //ktory znak w lini
    if(ktory_znak==200){ //gdy liczba spadnie do 0  to znaleziono rozwiazanie
        return true;
    }

    //cout<<"Linia :"<<linia<<", Znak: "<<ktory_znak<<endl;
    char znak;
    bool czy_znak_byl=false;
    int ktora_cyfra;
    bool czy_przeszlo=false;

    if(linia==0){ //000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000-----dla wyrazu 1
        if(wyraz1[(sizeof(wyraz1)-1)-ktory_znak]!='-'){ //gdy jest jeszcze nie ma koncca wrazu
            znak=wyraz1[(sizeof(wyraz1)-1)-ktory_znak]; //wybieranie znaku
            cout<<"Linia 1: "<<znak<<endl;
            for(int i=0; i<10; ++i){ //sprawdzanie czy dany znak jest juz w tablicy
                if(tab[i]==znak){
                    czy_znak_byl=true;
                    ktora_cyfra=i; //pobieraz indeks pod ktorym jest znak
                    break;
                }
            }

            if(czy_znak_byl==true){ //jezeli dany znak jest w tablicy
                czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, ktora_cyfra, cyfra2); //idziemy glebiej
                if(czy_przeszlo==true){
                    return true;
                }
                else{
                    return false;
                }
            }
            else{ //gdy znaku nie ma znaku w tablicy
                for(int i=0; i<10; ++i){ //przechodzimy tablice
                    if(tab[i]==' '){ //sprawdzamy dla pustego miejsca
                        ktora_cyfra=i;
                        tab[i]=znak;
                        czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, ktora_cyfra, cyfra2); //idziemy glebiej
                        if(czy_przeszlo==true){
                            return true;
                        }
                        else{ //gdy false to przywruc wartosc ' '
                            tab[i]=' ';
                        }
                    }
                }
                return false; //gdy wszystkie rozwiazania sa zle to zwroc false
            }
        }
        else{ //gdy sie skonczy string
            cout<<"Pusta linia 1:"<<endl;
            czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, 0, cyfra2); //idziemy glebiej bez zmany wartosci "liczba_znakow_do_odkrycia"
            if(czy_przeszlo==true){
                return true;
            }
            else{
                return false;
            }
        }

    }
    else if(linia==1){//111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111-----dla wyrazu 2
        if(wyraz2[(sizeof(wyraz2)-1)-ktory_znak]!='-'){ //gdy jest jeszcze nie ma koncca wrazu
            znak=wyraz2[(sizeof(wyraz2)-1)-ktory_znak]; //wybieranie znaku
            cout<<"Linia 2: "<<znak<<endl;
            for(int i=0; i<10; ++i){ //sprawdzanie czy dany znak jest juz w tablicy
                if(tab[i]==znak){
                    czy_znak_byl=true;
                    ktora_cyfra=i; //pobieraz indeks pod ktorym jest znak
                    break;
                }
            }

            if(czy_znak_byl==true){ //jezeli dany znak jest w tablicy{
                czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, cyfra1, ktora_cyfra); //idziemy glebiej
                if(czy_przeszlo==true){
                    return true;
                }
                else{
                    return false;
                }
            }
            else{ //gdy znaku nie ma w tablicy
                for(int i=0; i<10; ++i){ //przechodzimy tablice
                    if(tab[i]==' '){ //sprawdzamy dla kazdego pustego miejsca
                        ktora_cyfra=i;
                        tab[i]=znak;
                        czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, cyfra1, ktora_cyfra); //idziemy glebiej
                        if(czy_przeszlo==true){
                            return true;
                        }
                        else{ //gdy false to przywruc wartosc " "
                            tab[i]=' ';
                        }
                    }
                }
                return false; //gdy wszystkie rozwiazania sa zle to zwroc false
            }
        }
        else{ //gdy sie skonczy string
            cout<<"Pusta linia 2:"<<endl;
            czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, przeniesienie, poziom+1, cyfra1, 0); //idziemy glebiej bez zmany wartosci "liczba_znakow_do_odkrycia"
            if(czy_przeszlo==true){
                return true;
            }
            else{
                return false;
            }
        }

    } //2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222-----dla wyniku
    else{
        znak=wynik[(sizeof(wynik)-1)-ktory_znak]; //wybieranie znaku
        cout<<"Linia 3: "<<znak<<endl;
        int mozliwy_wynik=cyfra1+cyfra2; //suma
        bool odebrane_przeniesienie=przeniesienie; //przeniesienie
        int wyszukany_znak;

        if(odebrane_przeniesienie==true){ //dodaje ewentualne przeniesienie do sumy
            ++mozliwy_wynik;
            odebrane_przeniesienie=false;
        }

        if(mozliwy_wynik>=10){ //tworzy ewentualne przeniesienie gdy liczba jest wieksza od 9
            mozliwy_wynik=mozliwy_wynik%10;
            odebrane_przeniesienie=true;
        }

        if(mozliwy_wynik==0 && wynik[sizeof(wynik)-ktory_znak]=='-'){ //gdy jest koniec znakow (dla 1 oznaca koniec) i przypisane jest 0
            //cout<<"Wyjatek z 0"<<endl;
            return false;
        }

        if(odebrane_przeniesienie==true && wynik[sizeof(wynik)-ktory_znak]=='-'){ //gdy jest koniec znakow (dla 1 oznaca koniec) i jeszcze zostallo przeniesienie to zwroc falsz
            return false;
        }

        for(int i=0; i<10; ++i){ //czy dany znak jest juz w tablicy
            if(tab[i]==znak){
                czy_znak_byl=true;
                wyszukany_znak=i; //przypisz indeks tablicy
                break;
            }
        }

       if(czy_znak_byl==true){ //gdy pod konkretnym indeksem jest odpowiedni znak
            if(mozliwy_wynik==wyszukany_znak){ //gdy jest to ten sam znak to idz dalej
                czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, odebrane_przeniesienie, poziom+1, 0, 0);
                if(czy_przeszlo==true){
                    return true;
                }
                else{
                    return false;
                }
            }
            else{ //gdy jest to inny znak to zwroc false
                return false;
            }
        }
        else{ //gdy pod konkretnym indeksem nie ma odpowiedniego znaku
            if(tab[mozliwy_wynik]==' '){ //gdy pod konkretnym indeksem jest puste miejsce
                tab[mozliwy_wynik]=znak; //przypisz to miejsce
                czy_przeszlo=dodawanie(tab, wyraz1, wyraz2, wynik, odebrane_przeniesienie, poziom+1, 0, 0);
                if(czy_przeszlo==true){
                    return true;
                }
                else{
                    tab[mozliwy_wynik]=' '; //jak wruci false to cofnij zmiany
                    return false;
                }
            }
            else{ //gdy pod konkretnym indeksem jest nieodpowiedni znak zwroc false
                return false;
            }
        }
    }
}

bool odejmowanie(char *tab, char *wyraz1, char *wyraz2, char *wynik, bool porzyczka, int poziom, int cyfra1, int cyfra2){

}

int main(){
    string wyraz1; //zmienne
    string wyraz2;
    string wynik;
    char tab_wyraz1[200];
    char tab_wyraz2[200];
    char tab_wynik[200];
    for(int i=0; i<200; ++i){
        tab_wyraz1[i]='-';
        tab_wyraz2[i]='-';
        tab_wynik[i]='-';
    }
    cin>>wyraz1;
    cin>>wyraz2;
    cin>>wynik;
    char znak; //dzialanie
    znak=wyraz2.at(0);
    wyraz2=wyraz2.substr(1);
    char tab[]={' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}; //tablica rozwiazan
    bool porzyczka=false;
    bool przeniesienie=false;
    int poziom=0; //poziom rekurencji
    bool rozwiazanie;
    for(int i=0; i<wyraz1.size(); ++i){//ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
        tab_wyraz1[(sizeof(tab_wyraz1)-1)-i]=wyraz1[(wyraz1.size()-1)-i];
        cout<<(int)tab_wyraz1[(sizeof(tab_wyraz1)-1)-i];
    }
    cout<<endl;
    for(int i=0; i<wyraz2.size(); ++i){
        tab_wyraz2[(sizeof(tab_wyraz2)-1)-i]=wyraz2[(wyraz2.size()-1)-i];
        cout<<(int)tab_wyraz2[(sizeof(tab_wyraz2)-1)-i];
    }
    cout<<endl;
    for(int i=0; i<wynik.size(); ++i){
        tab_wynik[(sizeof(tab_wynik)-1)-i]=wynik[(wynik.size()-1)-i];
        cout<<(int)tab_wynik[(sizeof(tab_wynik)-1)-i];
    }//ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
    cout<<endl;
    if(znak=='+'){
        rozwiazanie=dodawanie(tab, tab_wyraz1, tab_wyraz2, tab_wynik, przeniesienie, poziom, 0, 0);

        for(int i=0; i<sizeof(tab_wyraz1); ++i){ //wypisz wyraz 1
            if(tab_wyraz1[i]!='-'){
                znak=wyraz1[i];
                for(int j=0; j<10; ++j){
                    if(znak==tab[j]){
                    cout<<j;
                    }
                }
            }
        }
        cout<<"+";
        for(int i=0; i<sizeof(tab_wyraz2); ++i){ //wypisz wyraz 2
            if(tab_wyraz2[i]!='-'){
                znak=wyraz2[i];
                for(int j=0; j<10; ++j){
                    if(znak==tab[j]){
                        cout<<j;
                    }
                }
            }
        }
        cout<<"=";
        for(int i=0; i<sizeof(tab_wynik); ++i){ //wypisz wynik
            if(tab_wyraz2[i]!='-'){
                znak=wynik[i];
                for(int j=0; j<10; ++j){
                    if(znak==tab[j]){
                        cout<<j;
                    }
                }
            }
        }
    }
    else{
        odejmowanie(tab, tab_wyraz1, tab_wyraz2, tab_wynik, porzyczka, poziom, 0, 0);
    }

    return 0;
}
/*PROBLEMY
ABB+A=ABA  -nic nie zapisuje (dla roznych dllugosci o min 2)
KRUK+KRUK=PTAKI   -obcina poczatek
TA+MI=OLE
TA+O=BCD
TAM+TAK=MILA
TA+TA=TAM -zly wynik
Abc+bc=ade -jest 0 na poczatku
*/