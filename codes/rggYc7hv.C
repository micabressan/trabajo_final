#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct igre_st{

	char ime[20];
	char zanr[20];
	char platforma[20];
	float cena;
	
	struct igre_st* next;
}igra;

void insert(igra**head, char ime[], char zanr[], char platforma[], float cena){

	igra*cvorkojidodajemo=(igra*)malloc(sizeof(igra));
	strcpy(cvorkojidodajemo->ime, ime);
	strcpy(cvorkojidodajemo->zanr, zanr);
	strcpy(cvorkojidodajemo->platforma, platforma);
	cvorkojidodajemo->cena=cena;
	cvorkojidodajemo->next=NULL;
	
	if (*head==NULL){
	*head=cvorkojidodajemo;
	return;
	}
	
	igra*current=*head;
	
	while(current->next!=NULL){
	current=current->next;
	}
	current->next=cvorkojidodajemo;
}

void ucitajizfajla(igra**head, char nazivfajla[]){

	FILE *f=fopen(nazivfajla, "r");
	if(f==NULL){
	printf("Greska pri otvaranju fajla za citanje");
	exit(0);
	}
	char ime[20];
	char zanr[20];
	char platforma[20];
	float cena;
	
	while(fscanf(f, "%s %s %s %f", ime, zanr, platforma, &cena)!=EOF){
		insert(head, ime, zanr, platforma, cena);
	}
}
 void izbrisilistu(igra**head){
 
 	igra * current;
 	igra* tmp;
 	current=*head;
 	
 	while(current->next!=NULL){
 		tmp=current;
 		current=current->next;
 		free(tmp);
 	}
 	*head=NULL;
 }
 
 void ispisiufajl(igra*head, char nazivfajla[])
{
	FILE *f=fopen(nazivfajla, "w");
	if(f==NULL){
	printf("Doslo je do greske pri ispisivanju u fajl");
	exit(0);
	}
	if(head==NULL){
	printf("Lista je prazna");
	return;
	}
	while(head!=NULL){
	fprintf(f, "%s %s %s %f\n", head->ime,head-> zanr, head->platforma, head->cena);
	head=head->next;
	}
	fclose(f);
	
}

igra * minCenaIgra(igra* head, char zanr[], char platforma[], char nazivfajla[]){
	
	igra * min=NULL;
	while(head!=NULL){
		if(strcmp(head->zanr, zanr)==0 && strcmp(head->platforma, platforma)==0){
			if(min==NULL){
			min=head;
			}
			if(head->cena<min->cena){
			min=head;
			}
	
	}
	
	
	head=head->next;
	}
	return min;
}

void ispisinakraj(igra*igrakojutrazimo, char nazivfajla[], char platforma[], char zanr[]){

	FILE *f=fopen(nazivfajla, "a");
	if(igrakojutrazimo==NULL){
	printf("Nema %s %s", platforma, zanr);
	fclose(f);
	return;
	}
	fprintf(f,"Najpovoljnija je %s %s %s %f", igrakojutrazimo->ime, igrakojutrazimo->platforma, igrakojutrazimo->zanr, igrakojutrazimo->cena);
	fclose(f);
}


int main(int numArg, char *args[]){

	if(numArg!=5){
		printf("Nedovoljno argumenata");
		exit(0);
}

	igra*head=NULL;
	ucitajizfajla(&head, args[3]);
	ispisiufajl(head, args[4]);
	igra* najjeftinija=minCenaIgra(head, args[1], args[2], args[3]);
	ispisinakraj(najjeftinija, args[4], args[4], args[4]);
	izbrisilistu(&head);
	
	

return 0;

}