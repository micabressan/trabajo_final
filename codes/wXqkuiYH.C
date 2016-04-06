#include <stdio.h>
#include <string.h>
#define N 20
#define M 30
#define MENU 1000

/* Struct && Typedef */
typedef struct data {
	int anno;
	int mese;
	int giorno;
} data;
typedef struct persona {
	char nome[N];
	char cognome[N];
	data nascita;
	int n_figli;
} persona;

/* Prototipi */
int menu();
void inserisci(persona *elenco, int *len, persona p);
void stampa_elenco(persona *elenco, int len);
void stampa_persona(persona *p);
void stampa_data(data *d);
persona *cerca(persona *elenco, int len, char *nome, char *cognome);
void cancella(persona *elenco, int *len, char *nome, char *cognome);
void copia(persona *to, persona *from);
float media_figli(persona *elenco, int len);

/* Implementazioni */
int main(void)
{
	persona elenco[M];
	persona p, *q;
	int len = 0, scelta = MENU;

	stampa_elenco(elenco, len);

	while (scelta != 0) {
		switch(scelta){
		case 1:
			inserisci(elenco, &len, p);
			strcpy(p.nome,"Thomas");
			strcpy(p.cognome, "Paterno");
			p.n_figli = 0;
			p.nascita.anno = 1994;
			p.nascita.mese = 6;
			p.nascita.giorno = 30;
			inserisci(elenco, &len, p);

			strcpy(p.nome,"Ivan");
			strcpy(p.cognome, "Paterno");
			p.n_figli = 0;
			p.nascita.anno = 1991;
			p.nascita.mese = 5;
			p.nascita.giorno = 4;
		        inserisci(elenco, &len, p);

			scelta = MENU;
			break;
		case 2:
			cancella(elenco, &len, "Thomas", "Paterno");
			scelta = MENU;
			break;
		case 3:
			q = cerca(elenco, len, "Ivan", "Paterno");
			stampa_persona(q);
			scelta = MENU;
			break;
		case 4:
			printf("Media dei figli: %f\n",
			       media_figli(elenco, len));
			scelta = MENU;
			break;

		case 0:
			break;
		case MENU:
			scelta = menu();
			break;
		}
	}
	printf("Programma terminato correttamente\n");
	return 0;
}

int menu() {
	int scelta;
	printf("[1] Inserisci una nuova persona\n");
	printf("[2] Cancella una persona\n");
	printf("[3] Ricerca un persona\n");
	printf("[4] Visualizza media figli\n");

	printf("[0] Uscita\n");
	printf("Scelta?? ");
	scanf("%d", &scelta);
	return scelta;
}

void stampa_elenco(persona *elenco, int len)
{
	int i;
	for (i = 0; i < len; i++)
		stampa_persona(&elenco[i]);
}

void inserisci(persona *elenco, int *len, persona p)
{
	elenco[*len] = p;
	*len = *len + 1;
}

void stampa_persona(persona *p)
{
	printf("Nome: %s\t Cognome:%s\t #Figli %d", p->nome, p->cognome,
	       p->n_figli);
	stampa_data(&(p->nascita));
	printf("\n");
}

void stampa_data(data *d)
{
	printf("\t Nato: %d-%d-%d", d->giorno, d->mese, d->anno);
}

persona *cerca(persona *elenco, int len, char *nome, char *cognome)
{
	int i;
	for (i = 0; i< len; i++){
		if ((strcmp(elenco[i].nome, nome) == 0) &&
		    (strcmp(elenco[i].cognome,cognome) == 0))
			return &elenco[i];
	}
}

void cancella(persona *elenco, int *len, char *nome, char *cognome)
{
	persona *p = cerca(elenco, *len, nome, cognome);
	persona last = elenco[*len-1];

	copia(p, &last);
	*len = *len -1;
}

void copia(persona *to, persona *from)
{
	strcpy(to->nome, from->nome);
	strcpy(to->cognome, from->cognome);
	to->n_figli = from->n_figli;
	to->nascita.anno = from->nascita.anno;
	to->nascita.mese = from->nascita.mese;
	to->nascita.giorno = from->nascita.giorno;
}

float media_figli(persona *elenco, int len)
{
	float media = 0;
	int i;
	for(i = 0; i < len; i++)
		media += (float)elenco[i].n_figli;
	return media /(float)len;
}