#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int MillerRabinPrimTeszt(int n, int iteration);
unsigned long long int gyorshatvanyozas(unsigned long long int alap, unsigned long long int kitevo, unsigned long long int mod);
int lnko(int x, int y);
long long int min(long long int x,long long int y);
int kibovitettEuklidesziAlgoritmus(int p, int q);
long long int kinaiMAradekTetel(long long int p,long long int q,long long int n,long long int c,long long int d);


int main(){

        //kulcsgeneralas

        srand(time(NULL));
        system("COLOR 06");

        printf("\n\n\t\tRSA titkositas!\n\n");

        int p;
        int q;
        long long int n;
        int phi_n;
        int e;
        int d;
        int m;
        int hossz;
        int kapott;
        int countp;
        int countq;
        long long int c;
        int vm;

while(1){ //végtelen ciklus

        p = rand() % 2000000;

        if(MillerRabinPrimTeszt(p, 10) == 1){
                int i = 0;
                for (hossz = 22; hossz >= 0; hossz--){ //max 24 db 1-es
                        kapott = p >> hossz;  //jobbra tolja/shifteli /binaris atalakitast vegez
                }
                //  000010100101111
                //  000100000000000

                countp = 0;

                while ( 1 << ++countp <= p ) //megszamoljuk,
                        ;
                        break;
        }
}

        //countq = countp;
        //printf("\nCOUNTQ = COUNTP %d\n", countq);
while(1){

        q = rand() % 2000000;

        if(MillerRabinPrimTeszt(q, 10) == 1){
                int i = 0;
                for (hossz = 22; hossz >= 0; hossz--){
                        kapott = q >> hossz;
                }

                countq = 0;

                while ( 1 << ++countq <= q )
                        ;
                if(countp == countq){ //ha a hossza egyenlő, akkor visszatér az azonos hosszú prímmel
                        if( p != q );
                                break;
                }
        }
}

        n = p * q;

        phi_n = (p - 1) * (q - 1);

       /* while (1){
                //e = rand()%((int)sqrt(phi_n) - 2);
                e = rand()%phi_n;
               if(lnko(phi_n, e) == 1){ //e relatív prím legyen phi_n-hez
                       break;
              }
        }*/

        for(e = 2; e < phi_n; e++){
                if( lnko(phi_n, e) == 1){
                        d = kibovitettEuklidesziAlgoritmus(phi_n, e);
                        if(d < 0)   //ha d negatív akkor hozzá kell adni a phi_n-t
                                d = d + phi_n;
                        if ((e * d) % phi_n == 1) //feltetel
                                break;
                }
        }

        printf("\t\tp =\t%d\n",p);
        printf("\t\tq =\t%d\n",q);
        printf("\t\tn =\t%d\n",n);
        printf("\t\tphi_n =\t%d\n",phi_n);
        printf("\t\te =\t%d\n",e);
        printf("\t\td =\t%d\n",d);

        printf("\n\t\tKerlek adj meg egy uzenetet!\n\t\tAz uzenet: ");
        scanf("%d", &m);

        c = gyorshatvanyozas(m, e, n);

        printf("\n\t\tA titkos uzenet: %d\n\n", c);

        vm = kinaiMAradekTetel(p,q,n,c,d);
        //vm = gyorshatvanyozas1(c,d,n);

        printf("\n\t\tA visszafejtett uzenet: %d\n", vm);



//printf("\n\nkinai: %lld\n", kinai(227,163,37001,5881,9409));
//printf("\nmiller: %d\n", MillerRabin(887,11));
//printf("\ngyorshatvanyozas1: %lld\n", gyorshatvanyozas1(19249,89499,134983));
//printf("\nkibovitett eukledeszi alg.: %lld\n", kibovitettEuklidesziAlgoritmus(2340,113));

        return 0;
}

//FUGGVENYEK
int MillerRabinPrimTeszt(int n, int iteration){
        if(n < 2){            // 2-nél kisebb szám NEM lehet prím
                return 0;
        }

        if(n != 2 && n % 2 == 0){         // Ha a n != 2 és páros, akkor az NEM lehet prím
                return 0;
        }

        int d = n-1; // pl n= 243 d=242

        while(d % 2 == 0){ // amíg a d páratlan nem lesz
                d /= 2;   // addig felezzük az d-t.
        }

        int  i;

        for (i = 0; i < iteration; i++){
                int a; // bázis
                a = rand()% (n - 1) +1; // random bázis 1-tõl p-1-ig

                int temp = d;
                int  mod;
                mod = gyorshatvanyozas(a,temp,n); // első feltétel


                while(temp != n - 1 && mod != 1 && mod != n - 1){ //második feltétel
                        mod = (mod * mod) % n;
                        temp *= 2;
                }

                if(mod != n - 1 && temp % 2 == 0){ // ha nem teljesül egyik feltétel sem
                        return 0; // nem prím
                }
        }

        return 1; //prím
}


unsigned long long int gyorshatvanyozas(unsigned long long int alap, unsigned long long int kitevo, unsigned long long int mod){

     //   printf("\n gyorshatvanyozas1: \n");
        unsigned long long int tomb [10000];
        int i = 0;

        while(kitevo >= 1){
                tomb[i] = kitevo % 2;
                kitevo = kitevo / 2;
                //printf("tomb i.eleme: %lld ,\tkitevo: %lld\n", tomb[i],kitevo);

                i++;
        }

        int tombMeret = i;
    //printf("tomb merete: %d", i);

        int hatvany [tombMeret];

        hatvany[0] = (unsigned long long int) (fmod((pow( alap, pow(2, 0))),mod));

        int j;

        for(j = 1; j <tombMeret; j++){
                hatvany[j] = (unsigned long long int) (fmod((pow( hatvany[j - 1], 2)), mod));
        }

        unsigned long long int result = 1;

        for(i = 0; i < tombMeret; i++){
                if(tomb[i] != 0){
                        result = (hatvany[i] * result) % mod;
                }
           //     printf("\n2^%d  result: %d\n", i, result);
        }
//while(result < 0){
  //      result += mod;
        return result;
}


int lnko(int x, int y){
        int i; // ciklus változó
        int minNum;
        minNum = min(x, y); // minNum-ba elmenti a kisebb számot

        for(i = minNum; i >= 1; i--){ //i=kisebb szám; 1 menjen i-ig, (azért nem 0-ig,mert 0-val nem lehet osztani); i csökken
                if((x % i == 0) && ( y % i == 0)){ // ha az x szám osztható i-vel, hogy nincs maradék, ÉS y osztható i-vel, hogy nincs maradék
                        return i; // akkor térjen vissza az i-vel
                }
        }
}


long long int min(long long int x,long long int y){
        if(x > y)
                return y;
        else
                return x;
}


int kibovitettEuklidesziAlgoritmus(int p, int q){
        int rk[100];
        int qk[100];
        int xk[100];
        int yk[100];
        int n = 0;
        int x = 0;
        int y = 0;

        rk[0] = p;
        rk[1] = q;
        qk[0] = 0;
        xk[0] = 1;
        xk[1] = 0;
        yk[0] = 0;
        yk[1] = 1;

        int k = 1; //ciklus változó

       //táblázat
        while(rk[k] != 0) { // amíg a rk nem lesz 0
                rk[k + 1] = (rk[k - 1] % rk[k] );
                qk[k] = (rk[k - 1] / rk[k] );
                xk[k + 1] = xk[k] * qk[k] + xk[k - 1];
                yk[k + 1] = yk[k] * qk[k] + yk[k - 1];
                k++;
        }

        n = k - 1; // azért kell kivonnom belõle az 1-et, mivel k=1-rõl indítottam a ciklust


        for (k = 0; k <= n; k++){
                x=pow((-1), n) * xk[k];
                y=pow((-1), n - 1) * yk[k];
        }

        //kiírja a táblázatot
        /*for (k = 0; k < n; k++){
                printf("%d\v ",rk[k]);
                printf("%d\v ",qk[k]);
                printf("%d\v ",xk[k]);
                printf("%d\v ",yk[k]);
                printf("\n");
        }*/
        return y;
}


long long int kinaiMAradekTetel(long long int p, long long int q, long long int n,long long int c,long long int d){
        long long int y1;
        long long int y2;
        long long int c1;
        long long int c2;
        long long int vm; //visszafejtett uzenet
        long long int dp;
        long long int dq;
        long long int m1;
        long long int m2;



        dp = d % (p-1);
        //  printf("\nDP: %lld\n", dp);

        dq = d % (q-1);
        //  printf(" \nDQ: %lld\n", dq);

       // printf("\ndp=%d\n", dp);
       // printf("\ndq=%d\n", dq);

      //  printf("\nCCCCCCC=%d\n", c);

        y1 = kibovitettEuklidesziAlgoritmus(p, q);
        y2 = kibovitettEuklidesziAlgoritmus(q, p);

        // printf("y1 = %lld\n", y1);
        //printf("y2 = %lld\n", y2);

        // printf("\n C1\n");
        c1 = gyorshatvanyozas(c, dp, p);
        //printf("\n C1 = %d\n",c1);

        //printf("\n C2\n");
        c2 = gyorshatvanyozas(c, dq, q);
        //printf("\n C2 = %d\n",c2);

        m1 = fmod(c1*q*y1 , n);
        m2 = fmod(c2*p*y2 , n);
        vm =  m1 + m2;

       /* printf("\nKInaIBan\n");
        printf("y1 = %lld\n", y1);
        printf("y2 = %lld\n", y2);
        printf("c1 = %lld\n", c1);
        printf("c2 = %lld\n", c2);
        printf("vm = %lld\n", vm);
*/
        return vm;
}