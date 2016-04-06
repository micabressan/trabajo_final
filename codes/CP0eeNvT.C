#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Dete{
        char ime[21], ulica[21];
        unsigned int broj;

}Dete;

typedef struct sElem{
        Dete d;
        struct sElem *sled;
}Elem;

Elem *dodaj(Elem *lst, Dete d)
{
        Elem *novi, *tek;
        novi=malloc(sizeof(Elem));
        novi->d=d;
        novi->sled=NULL;
        if(!lst) lst=novi;
        else{ for(tek=lst; tek->sled!=NULL; tek=tek->sled);
                        tek->sled=novi;
                }
        return lst;
}

void brisi(Elem *lst)
{
        Elem *stari;
        while(lst){
                stari=lst;
                lst=lst->sled;
                free(stari);
        }
}

void sortiraj(Elem *lst)
{
        Elem *tek1, *tek2;
        Dete pom;
        for(tek1=lst; tek1!=NULL; tek1=tek1->sled){
                for(tek2=tek1->sled; tek2!=NULL; tek2=tek2->sled){
                        if(tek1->d.broj>tek2->d.broj)
                        {
                                pom=tek1->d;
                                tek1->d=tek2->d;
                                tek2->d=pom;
                        }
                }
        }
}

void main()
{
        FILE *zelje, *adresar;
        Dete d;
        zelje=fopen("zelje.txt", "r");
        adresar=fopen("adresar.dat", "rb");
        Elem *lst=NULL,*tek1,*tek2;
        int broj,max=0, br=0;
        char ulica_max[21], ime[21], poklon[21],ulica[21];



        while(fscanf(adresar,"%s%s%d",ime, ulica, &broj)!=EOF)
        {
                lst=dodaj(lst,d);
        }

        for(tek1=lst; tek1!=NULL; tek1=tek1->sled)
        {
                for(tek2=tek1->sled; tek2!=NULL; tek2=tek2->sled)
                {
                        if(!strcmp(tek1->d.ulica, tek2->d.ulica))
                        br++;

                }
                if(br>max)
                {
                        max=br;
                        strcpy(ulica_max,tek1->d.ulica);
                }

        }

        printf("\n%s\n", ulica_max);

        sortiraj(lst);

        while(fscanf(zelje, "%s%s", ime, poklon)!=EOF)        {
                for(tek1=lst; tek1!=NULL; tek1=tek1->sled)
                {
                        if(!strcmp(tek1->d.ime,ime) && !strcmp(tek1->d.ulica,ulica_max))
                        {

                                printf("%d %s %s\n", tek1->d.broj,ime,poklon);
                        }
                }
        }

        fclose(zelje);
        fclose(adresar);
        brisi(lst);
}