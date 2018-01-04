//Idomus menesiai
#include <iostream>
#include <iomanip>
using namespace std;
int main(){
   int pr, pb;                       //periodo pradzia ir pabaiga
   int dpr;                          //pradiniu metu savaites diena (sausio 1d)
   int kokie;                        //keliamieji metai ar ne
   cout << "Iveskite pradinius ir galutinius intervalo metus: ";
   cin >> pr >> pb;
   cout << "Iveskite, kuria savaites diena prasideda pradiniai metai: 1 - pirmadienis ir t.t.";
   cin >> dpr;
   while (pr <= pb)
   {
       if (pr % 400 == 0 || (pr % 100 != 0 && pr % 4 == 0)) kokie = 0; //metai keliamieji
       else kokie = 1;                                                 //nekeliamieji
       if (kokie == 0) {
         if (dpr == 1) cout << pr << " kovas" << endl;                 //pagal sausio pirm‡ nustatoma,
         else if (dpr == 2) cout << pr << " rugpjutis" << endl;         //kuri menesi bus po 5 savaitgalius
            else if (dpr == 3) cout << pr << " geguze" << endl;
              else if (dpr == 4) cout << pr << " spalis" << endl;
                else if (dpr == 5) cout << pr << " sausis, liepa" << endl;
                  else if (dpr == 6) cout << pr << " gruodis" << endl;
                    else cout << pr << " nera" << endl;
          dpr = dpr + 2;
          if (dpr % 7 == 0) dpr = 7;
          else dpr = dpr % 7;
          pr = pr + 1;
       }
       else {
       if (dpr == 1) cout << pr << " nera" << endl;
         else if (dpr == 2) cout << pr << " kovas" << endl;
            else if (dpr == 3) cout << pr << " rugpjutis" << endl;
              else if (dpr == 4) cout << pr << " geguze" << endl;
                else if (dpr == 5) cout << pr << " sausis, spalis" << endl;
                  else if (dpr == 6) cout << pr << " liepa" << endl;
                    else cout << pr << " gruodis" << endl;
          dpr = dpr + 1;
          if (dpr % 7 == 0) dpr = 7;
          else dpr = dpr % 7;
          pr = pr + 1;
       }
   }
   return 0;
}