#include <iostream>
using namespace std;
int main(){ 
    /////////////
    int pocet,i2,i,oknos,oknov,dvere,dverep,dverek,kominz,komink,kominl,kominp;
    char end[50];
    cout << "Zadej velikost domecku, vetsi nez 7\n";
    cin >> pocet;
    cin.ignore();
    while (pocet<8) {cout << "Cislo musi byt vetsi nez 7, zkus to znovu";
        cin >> pocet;
        cin.ignore();
    }
    oknos=pocet*0.3;
    oknov=pocet*0.8;
    dvere=pocet*0.6;
    kominz=pocet*0.2;
    komink=pocet*0.8;
     
    pocet*=2;
    int max=pocet/2+1;
    int min=pocet/2-1;
    dverep=pocet*0.4;
    dverek=pocet*0.7;
    kominl=pocet*0.7;
    kominp=pocet*0.8;
    //konec deklaraci
    //Zacatek strechy
    for (i2=1;i2<=pocet/2;i2++) {
        cout <<"     ";
        for (i=1;i<=pocet;i++) {
             
            //standart
            if (i>min && i<max) {cout << "-";} 
            ///standart
            else if (i2>=kominz && i2<=komink && i>=kominl && i<=kominp) {
            cout <<"-";
            } 
            else
            {cout <<" ";}
             
        }
        max+=1;
        min-=1;
        cout << "\n";
    }
    //konec strechy
    //zacatek spodku
    for (i2=1;i2<=pocet/2;i2++) {
        cout <<"     ";
        if (i2!=pocet/2) { //prostredek
            for (i=1;i<=pocet;i++) {
             
                if (i==1 || i==pocet) {cout << "-";} 
                //////////////////////////// okna
                else if  (i2<(oknov*0.6) && i2>(oknos*0.5) && i>oknos && i<oknov ) {
                    cout << "-";
                     
                } 
                else if  (i2<oknov*0.6 && i2>oknos*0.5 && i>oknos+pocet/2 && i<oknov+pocet/2) {
                    cout << "-";
                     
                }///////////////////////// okna konec
                //dvere zacatek
                else if  (i2==dvere && i>=dverep && i<=dverek ) { //vrch dveri
                    cout << "-";
                     
                }
                else if  (i2>dvere ) { if (i==dverep || i==dverek) {  //strany
                                        cout << "-";} else {cout<< " ";}
                     
                }
                //// dvere konec    
                 
                 
                else
                {cout <<" ";}
             
            /////////////////////
            }
        }   else { for (i=1;i<=pocet;i++) {
                    cout << "-";
            }
            }
        cout << "\n";
    }
     
    cout << "Stiskni enter";
    cin.getline(end,30);
 
    return 0;
}