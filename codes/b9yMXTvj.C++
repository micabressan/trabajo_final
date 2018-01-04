#include <iostream>
#include <string>
#include <fstream>
using namespace std;

typedef struct {
    string id;
    string patro;
    string cislo_mistnosti;
    string kapacita_sedadel;
    string cena_za_den_rezervace;

}mistnosti;

void nahraj_mistnosti(mistnosti mistnosti[]) {
    ifstream soubor;
    string pomocna;
    unsigned int index=0;
    unsigned int poradi=0;
    string cesta="mistnosti.txt";
    soubor.open(cesta.c_str(),ios::in);
    if(!soubor.is_open()){
        cout<<"Error"<<endl;
        return ;
    }
    else
    {
        while(getline(soubor,pomocna))
        {
           for(unsigned int i=0;i<pomocna.length();i++)
            {
                if(pomocna[i]==';')
                {
                    poradi++;
                    continue;
                }

                 if(poradi==0){  mistnosti[index].id +=pomocna[i];
                 }
                 if(poradi==1){ mistnosti[index].patro +=pomocna[i];
                 }
                 if(poradi==2){ mistnosti[index].cislo_mistnosti +=pomocna[i];
                 }
                 if(poradi==3){ mistnosti[index].kapacita_sedadel +=pomocna[i];
                 }
                 if(poradi==4){ mistnosti[index].cena_za_den_rezervace +=pomocna[i];
                 }
            }
            index++;
            poradi = 0;
        }

       }
}

unsigned int spoctiradky(const char* cesta)
{
  unsigned int x = 0;
  string y;
  ifstream otevri;
  otevri.open(cesta);
  if(!otevri.is_open()){
        cout<<"Error"<<endl;
        return -1;
  }
  else{
    while(getline(otevri, y))
    {
        x++;
    }
    otevri.close();
    return x;
    }
}
int main()
{
    int pocetradku = spoctiradky("mistnosti.txt");
    mistnosti mistnosti[pocetradku];
    nahraj_mistnosti(mistnosti);
    for(int i = 0; i<pocetradku;i++)
    {
             cout<<"ID: "<< mistnosti[i].id << endl;
             cout<<"patro: "<< mistnosti[i].patro <<endl;
             cout<<"cislo mistnosti: "<< mistnosti[i].cislo_mistnosti << endl;
             cout<<"kapacita sedadel: "<< mistnosti[i].kapacita_sedadel << endl;
             cout<<"cena: "<< mistnosti[i].cena_za_den_rezervace << endl;

    }
    return 0;
}