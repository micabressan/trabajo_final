#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Univerzitet{
    char naziv[31];
    int pris, utic, otvo, izuz;
}univer;

typedef struct Poeni_rang{
    float poeni;
    int rang;
}poeni_rang;

typedef struct sElem{
    univer u;
    poeni_rang stari, novi;
    struct Elem *sled;
}Elem;

Elem *procitaj(Elem *lst, FILE *fajl){
    Elem *novi, *tek;
    univer u;
    while(fscanf(fajl, "%s %d %d %d %d", u.naziv, &u.pris, &u.utic, &u.otvo, &u.izuz)!=EOF){
        novi=malloc(sizeof(Elem));
        if(novi==NULL) printf("\nAlokacija neuspela!\n");
        novi->sled=NULL;
        strcpy(novi->u.naziv,u.naziv);
        novi->u.pris=u.pris;
        novi->u.utic=u.utic;
        novi->u.otvo=u.otvo;
        novi->u.izuz=u.izuz;
        novi->sled=NULL;
        if(!lst) lst=novi;
        else{
            for(tek=lst; tek->sled!=NULL; tek=tek->sled);
            tek->sled=novi;
        }
    }

    racunaj(lst);

    return lst;
}

void racunaj(Elem *lst){
    Elem  *tek; int i=1;
    for(tek=lst; tek!=NULL; tek=tek->sled){
        tek->stari.rang=i;
        tek->novi.rang=i;
        tek->stari.poeni=0.2*tek->u.pris+0.5*tek->u.utic+0.15*tek->u.otvo+0.15*tek->u.izuz;
        tek->novi.poeni=0.5*tek->u.pris+1/6*tek->u.utic+1/6*tek->u.otvo+1/6*tek->u.izuz;
        i++;
    }

}

void rang(Elem *lst){
    Elem *tek1, *tek2;
    int pom;
    for(tek1=lst; tek1!=NULL; tek1=tek1->sled){
        for(tek2=tek1; tek2!=NULL; tek2=tek2->sled){
            if(tek1->stari.poeni>tek2->stari.poeni){
                pom=tek1->stari.rang;
                tek1->stari.rang=tek2->stari.rang;
                tek2->stari.rang=pom;
            }
            if(tek1->novi.poeni>tek2->novi.poeni){
                pom=tek1->novi.rang;
                tek1->novi.rang=tek2->novi.rang;
                tek2->novi.rang=pom;
            }
        }
    }
}
void brisi(Elem *lst){
    Elem *stari;
    while(lst){
        stari=lst;
        lst=lst->sled;
        free(stari);
    }
}
void nadji(Elem *lst, FILE *fajl){
    int max=0;
    char naj_univ[31];
    Elem *tek;
    for(tek=lst; tek!=NULL; tek=tek->sled){
        if((tek->novi.rang - tek->stari.rang) >= max){
            max=tek->novi.rang - tek->stari.rang;
            strcpy(naj_univ,tek->u.naziv);
        }
    }
    fprintf(fajl, "%s", naj_univ);
}

void main()
{
    FILE *ulaz, *izlaz;
    Elem *lst=NULL;

    ulaz=fopen("univerziteti.txt", "r");
    izlaz=fopen("izlaz.txt", "w");

    lst=procitaj(lst,ulaz);

    rang(lst);

    nadji(lst, izlaz);

    brisi(lst);

    fclose(ulaz);
    fclose(izlaz);


}