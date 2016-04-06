#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct imenik{
       char ime[31], broj[11];
}Imenik;

typedef struct elem{
    Imenik i;
    struct elem *sled;
}Elem;

Elem *ucitaj(Elem *lst, Imenik i){
    Elem *novi, *tek;
    novi=malloc(sizeof(Elem));
    novi->i=i;
    novi->sled=NULL;
    if(!lst) lst=novi;
    else{
     for(tek=lst; tek->sled!=NULL; tek=tek->sled);
      tek->sled=novi;

    }
    return lst;
}

void obrisi(Elem *lst){
    Elem *stari;
    while(lst){
        stari=lst;
        lst=lst->sled;
        free(stari);
    }
}

void main()
{
    FILE *ulaz, *izlaz, *imenik;
    Elem *lst=NULL, *tek;
    Imenik i;
    char c, ime[31];
    int j=0,be;

    ulaz=fopen("ulaz.txt","r");
    izlaz=fopen("izlaz.txt","w");
    imenik=fopen("imenik.dat","rb");
    if(ulaz==NULL || izlaz==NULL || imenik==NULL){ printf("jbg promaklo!\n"); exit(1);}

    while(fscanf(imenik,"%s %s", i.ime, i.broj)!=EOF){
                lst=ucitaj(lst, i);
    }
    while((c=fgetc(ulaz))!=EOF){
        if(c=='['){
            j=0;
            be=0;
            while((c=fgetc(ulaz))!=']')
            {
                ime[j++]=c;

            }
            ime[j]='\0';
            for(tek=lst; tek!=NULL; tek=tek->sled){
                if(!strcmp(tek->i.ime,ime)){
                        fprintf(izlaz,"%s",tek->i.broj);
                        be=1;
                //fputs(tek->i.broj, izlaz);
                }
                //fputc(' ',izlaz);
            }
            if(!be) fprintf(izlaz,"[%s]",ime);
        }
        else fputc(c, izlaz);

    }

    fclose(ulaz);
    fclose(izlaz);
    fclose(imenik);
    obrisi(lst);
}