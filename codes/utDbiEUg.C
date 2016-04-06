#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct uni{char naziv[31]; int fp; int ut; int otv; int izu;}Uni;
typedef struct stara{double poeni; int rang;}Stara;
typedef struct nova{double poeni; int rang;}Nova;
typedef struct elem{Uni u; Stara s; Nova n; struct elem *sl;}Elem;

Elem *na_kraj(Elem *prvi, Uni uu){
	Elem *tek, *novi;

	novi=(Elem*)malloc(sizeof(Elem));
	if(novi==NULL) exit(2);
	strcpy(novi->u.naziv,uu.naziv);
	novi->u.fp=uu.fp;
	novi->u.ut=uu.ut;
	novi->u.otv=uu.otv;
	novi->u.izu=uu.izu;
	novi->sl=NULL;

	if(prvi==NULL)
		prvi=novi;
	else 
		for(tek=prvi;tek->sl;tek=tek->sl);
			tek->sl=novi;
	novi->s.poeni=((1/4)*novi->s.fp+(1/2)*novi->s.ut+(3/20)*novi->s.otv+(3/20)*novi->s.izu);
	novi->n.poeni=((1/2)*novi->n.fp+(1/6)*novi->n.ut+(1/6)*novi->n.otv+(1/6)*novi->n.izu);

}

void rangiraj(Elem *prvi){
	Elem *tek;
	Stara *a;
	Nova *b;
	int n=0, i=0, k=0, r=1;
	for(tek1=prvi;tek1;tek1=tek1->sl)
		n+=1;
	a=(Stara*)malloc(n*sizeof(Stara));
	if(a==NULL) exit(3);
	for(tek=prvi;tek;tek=tek->sl){
		a([i++].poeni)=tek->s.poeni;
	}
	b=(Nova*)malloc(n*sizeof(Nova));
	if(b==NULL) exit(4);
	for(tek=prvi;tek;tek=tek->sl){
		b([k++].poeni)=tek->n.poeni;
	}
	a[0].rang=r;
	for(i=1;i<(n-1);i++){
		if(a[i].poeni<a[])
	}
	
	


	free a;
	free b;

}

void main(){
	Elem *prvi=NULL;
	FILE *univerziteti, *izlaz;
	Uni uu;


	univerziteti=fopen("univerziteti.txt","r");
	izlaz=fopen("izlaz.txt","w");
	if(!univerziteti || !izlaz) exit(1);

	while(!feof(univerziteti)){
		if(fscanf(univerziteti,"%s %d %d %d %d \n", uu.naziv, &uu.fp, &uu.ut, &uu.otv, &uu.izu)==EOF) break;
		prvi=na_kraj(prvi,uu);
	}
	rangiraj(prvi);
}