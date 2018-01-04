#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define N 3
#define MAX 20


int main()
{
    struct dane{
    char imie[MAX];
    char nazwisko[MAX];
    int rok;
};
    struct dane osoba[N];

    int licznik=0;
    FILE *wskaznik=fopen("in.txt","r");
    if(wskaznik!=NULL)
        printf("otwarto poprawnie");
    else
        printf("nie udalo sie otworzyc pliku");
    for(int i=0;i<N;i++){
            fscanf(wskaznik,"%s %s %d",osoba[i].imie,osoba[i].nazwisko,&osoba[i].rok);}
    fclose(wskaznik);
    FILE *fpointer=fopen("wynikowy.txt","w+");
    for(int l=0;l<N;l++){
            fprintf(fpointer,"%s %s %d\n",osoba[l].imie,osoba[l].nazwisko,osoba[l].rok);

    }



    fclose(fpointer);
    return 0;
}