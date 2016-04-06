#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX 10000

typedef struct proizvod{int sifra; int zapremina; char naziv[51];} Proizvod;
typedef struct elem{Proizvod p; struct elem *sl;}Elem;
typedef struct elem1{Elem e; struct elem1 *sl;}Elem1;

Elem *na_kraj(Elem *prvi, Proizvod pp){
	Elem *novi, *tek;

	novi=(Elem*)malloc(sizeof(Elem));
	if(novi==NULL) exit(2);

	novi->p.sifra=pp.sifra;
	novi->p.zapremina=pp.zapremina;
	strcpy(novi->p.naziv,pp.naziv);

	novi->sl=NULL;
	if(prvi==NULL)
		prvi=novi;
	else
		for(tek=prvi;tek->sl;tek=tek->sl);
			tek->sl=novi;
	return(prvi);
}

void sortiraj_listu(Elem *prvi){
	Elem *tek1, *tek2;
	int sifra, zapremina;
	char naziv[51];
	tek1=prvi;
	while(tek1->sl){
		tek2=tek->sl;
		while(tek2){
			if(tek2->p.zapremina>tek1->p.zapremina)
				zapremina=tek1->p.zapremina;
				tek1->p.zapremina=tek2->p.zapremina;
				tek2->p.zapremina=zapremina;

				sifra=tek1->p.sifra;
				tek1->p.sifra=tek2->p.sifra;
				tek2->p.sifra=sifra;

				strcpy(naziv,tek1->p.naziv);
				strcpy(tek1->p.naziv, tek2->p.naziv);
				strcpy(tek->p.naziv,naziv);

				tek2=tek2->sl;
		}
		tek1=tek1->sl;
	}
}

void obrada(Elem *prvi){
	Elem *tek=prvi, *tek1;
	int ukupna_zapremina, br;
	Elem1 *novi;

	while(tek){

		novi=(Elem1*)malloc(sizeof(Elem1));
		if(novi==NULL) exit(3);

		novi=tek;
		ukupna_zapremina=tek->p.zapremina;
		tek1=tek->sl;
		br=0;
		while(tek1){
			if(tek1->p.zapremina+ukupna_zapremina<=MAX){
							tek1=tek1->sl;
		}
			else 
	}
}

void brisi(Elem *prvi){
	Elem *tek;
	while(prvi){
		tek=prvi;
		prvi=prvi->sl;
		free(tek);
	}
}

void main(){
	Elem *prvi=NULL, tek
	FILE *posiljka;
	Posiljka pp;

	posiljka=fopen("posiljka.txt", "r");
	if(!posiljka) exit(1);

	while(!feof(posiljka)){
		if(fscanf("%d %d %s \n", &pp.sifra, &pp.zapremina, pp.naziv)==EOF) break;
		prvi=na_kraj(prvi,pp);
	}
	sortiraj_listu(prvi);
	obrada(prvi);
	brisi(prvi);
}