/*
ESAME DI PROGRAMMAZIONE 1
15-12-2017

Il seguente codice crea un file ("archivio") costituito da una sequenza di strutture
che hanno un campo "numeri" (array di ARRLEN int) e un campo (stringa) "nome" di STRINGALEN
caratteri piu' il terminatore nullo.
Si richiede la generazione di un nuovo file ("finale") in cui le strutture abbiano i seguenti campi:

int minimo;
int massimo; 
float media;
char nomeord[STRINGALEN+1];

1) il campo "minimo"  contiene il minimo dell'array "numeri";
2) il campo "massimo"  contiene il massimo dell'array "numeri";
2) il campo "media" contiene la media aritmetica dell'array "numeri";
3) il campo stringa "nomeord" contiene nell'ordine prima tutte le vocali del campo "nome",
   poi tutte le "consonanti", poi tutte le cifre, e in ultimo tutti gli altri caratteri.

Il file "finale" deve risultare costruito con i dati delle strutture ordinate secondo
il valore del campo "minimo".
Si richiede l'uso dell'allocazione dinamica di memoria (suggerimento: liste ordinate).
Opzionale: Visualizzare sullo schermo le strutture elaborate.
*/


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define ARRLEN 50
#define STRINGALEN 100
#define MAXREC 500

typedef 
  struct dato
  {
    int numeri[ARRLEN];
    char nome[STRINGALEN+1];
  }
  t_dato;
  
typedef
	struct 
	{
		int minimo;
		int massimo; 
		float media;
		char nomeord[STRINGALEN+1];
	}t_datofinale;
	
typedef
	struct lista
	{
		t_datofinale info;
		struct lista *prox;
	}
	t_lista;

//Dichiarazioni
int creainput();
t_lista* leggi_archivio();
void elabora_struttura(t_dato*, t_datofinale*);
void elabora_minimo(t_dato*, t_datofinale*);
void elabora_massimo(t_dato*, t_datofinale*);
void elabora_media(t_dato*, t_datofinale*);
void elabora_stringa(t_dato*, t_datofinale*, int);
int isvocale(char);
int isconsonante(char);
int inserisci_lista(t_lista**, t_datofinale);
int scrivi_finale(t_lista**);
void print_struttura(t_datofinale);


int main()
{
  int ok;
  t_lista *p;
  
  ok = creainput();
  if (ok)
    printf("Errore. File di input non creato!\n");
  else
    printf("File di input correttamente generato!\n"); 
  
  p = leggi_archivio();  
  if(p)
  {
	 ok = scrivi_finale(&p);
	 if(!ok)
	 {
		 printf("File finale non creato!\n");
		 return EXIT_FAILURE;
	 }
	 else
	 {
		 printf("File finale creato correttamente\n");
		 return EXIT_SUCCESS;
	 }
 }
 else
 {
	 return EXIT_FAILURE;	
 } 
}



int creainput()
{
  FILE *f;
  t_dato x;
  int i,k,n;
  srand(time(0));
  n = MAXREC + rand()%MAXREC;
  if ((f = fopen("archivio","wb")))
  {	
    for (k = 0; k < n; k++)
	{
	  for (i=0; i<ARRLEN; i++)
		x.numeri[i]=rand()%10000;
	  for (i=0;i < STRINGALEN; i++)
	    x.nome[i]= 33 + rand()%95;
	  x.nome[STRINGALEN]='\0';
	  fwrite(&x,sizeof(t_dato),1,f);
	}
	fclose(f);
	return 0;
  }
  else
  {
	printf("Errore nell'apertura del file.\n");
	return 1;
  }	
}

//funzione che legge l'archivio e costruisce la lista ordinata, restituisce il puntatore alla lista
t_lista* leggi_archivio(void)
{
	FILE* a;
	t_dato da_elaborare;
	t_datofinale elaborato;
	t_lista *p;
	
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	if((a = fopen("archivio", "rb")))
	{
		//leggiamo fino alla fine il file archivio
		while(!feof(a))
		{
			fread(&da_elaborare, sizeof(t_dato), 1, a);
			//elaboriamo la struttura letta
			elabora_struttura(&da_elaborare, &elaborato);
			//se inserisce correttamente in lista, continua a leggere, altrimenti chiudi il file e torna puntatore a NULL
			if(inserisci_lista(&p, elaborato))
			{
				continue;
			}
			else
			{
				printf("Problemi nell'allocazione di \"temp\"\n");
				fclose(a);
				return NULL;
			}
		}
		printf("File archivio letto correttamente\n");
		fclose(a);
		return p;
	}
	else
	{
		printf("Errore nell'apertura del file \"archivio\"\n");
		return NULL;
	}
}

//funzione che elaborerà la struttura letta dal file archivio
void elabora_struttura(t_dato* iniziale, t_datofinale* finale)
{
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	elabora_minimo(iniziale, finale);
	elabora_massimo(iniziale, finale);
	elabora_media(iniziale, finale);
	elabora_stringa(iniziale, finale, STRINGALEN+1);
}

//funzione che troverà il minimo nell'array numeri della struttura "iniziale"
void elabora_minimo(t_dato* iniziale, t_datofinale* finale)
{
	//il campo "minimo"  contiene il minimo dell'array "numeri"
	int i;
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	finale->minimo = iniziale->numeri[0];
	for(i = 1; i < ARRLEN; i++)
	{
		if(iniziale->numeri[i] < finale->minimo)
		finale->minimo = iniziale->numeri[i];
	}
}

//funzione che troverà il massimo nell'array numeri della struttura "iniziale"
void elabora_massimo(t_dato *iniziale, t_datofinale* finale)
{
	//il campo "massimo"  contiene il massimo dell'array "numeri"
	int i;
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	finale->massimo = iniziale->numeri[0];
	for(i = 1; i < ARRLEN; i++)
	{
		if(iniziale->numeri[i] > finale->massimo)
			finale->massimo = iniziale->numeri[i];
	}
}

//funzione che stabilirà la media aritmetica dell'array numeri e lo pone in campo media del dato finale
void elabora_media(t_dato* iniziale, t_datofinale* finale)
{
	//il campo "media" contiene la media aritmetica dell'array "numeri"
	int i;
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	for(i = 0; i < ARRLEN; i++)
	{
		finale->media += (float)iniziale->numeri[i];
	}
	finale->media = finale->media/(float)ARRLEN;
}

//funzione che ordinerà la stringa nome riempiendo la stringa nomeord, entrambi di dimensioni dim
void elabora_stringa(t_dato* iniziale, t_datofinale* finale, int dim)
{
	//il campo stringa "nomeord" contiene nell'ordine prima tutte le vocali del campo "nome", poi tutte le "consonanti", poi tutte le cifre, e in ultimo tutti gli altri caratteri
	int i, j;
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	//scorrimento array per vocali
	for(i = j = 0; i < dim && j < dim; i++)
	{
		if(isvocale(iniziale->nome[i]))
		{
			finale->nomeord[j] = iniziale->nome[i];
			j++;
		}
	}
	//scorrimento array per consonanti
	for(i = 0; i < dim && j < dim; i++)
	{
		if(isconsonante(iniziale->nome[i]))
		{
			finale->nomeord[j] = iniziale->nome[i];
			j++;
		}
	}
	//scorrimento array per cifre
	for(i = 0; i < dim && j < dim; i++)
	{
		if(isdigit(iniziale->nome[i]))
		{
			finale->nomeord[j] = iniziale->nome[i];
			j++;
		}
	}
	//scorrimento array per gli altri caratteri
	for(i = 0; i < dim && j < dim; i++)
	{
		if(!isconsonante(iniziale->nome[i]) && !isvocale(iniziale->nome[i]) && !isdigit(iniziale->nome[i]))
		{
			finale->nomeord[j] = iniziale->nome[i];
			j++;
		}
	}
}

//controlla se c è vocale, 1 se è vero, 0 se è falso
int isvocale(char c)
{
	switch(c)
	{
		case 'A':;
		case 'a':;
		case 'E':;
		case 'e':;
		case 'I':;
		case 'i':;
		case 'O':;
		case 'o':;
		case 'U':;
		case 'u': return 1; break;
		default: return 0; break;
	}
}

//controlla se c è consonante, 1 se è vero, 0 se è falso
int isconsonante(char c)
{
	if(isalpha(c) && !isvocale(c))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

//funzione che inserire la struttura letta dall'archivio in una lista ordinata, ritorna 1 se fallisce
int inserisci_lista(t_lista** ptr, t_datofinale da_inserire)
{
	t_lista *temp, *prec, *corr;
	
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	temp = (t_lista*)malloc(sizeof(t_lista));
	if(temp)
	{
		temp->info = da_inserire;
		temp->prox = NULL;
		//se ptr non è NULL scorri la lista finchè non trovi il valore più grande di minimo 
		if(*ptr)
		{
			prec = NULL;
			corr = *ptr;
			//finchè il campo minimo dell'elemento della lista è più piccolo dell'elemento da inserire, scorri
			while((corr) && (corr->info.minimo < da_inserire.minimo))
			{
				prec = corr;
				corr = corr->prox;
			}
			//se prec non è NULL, inserisci tra prec e corr
			if(prec)
			{
				prec->prox = temp;
				temp->prox = corr;
			}
			//altrimenti inserisci come primo elemento della lista
			else
			{
				temp->prox = *ptr;
				*ptr = temp;
			}
		}
		else
		{
			*ptr = temp;
		}
		
		return 1;
	}
	else
	{
		return 0;
	}
}

//funzione che genera il file finale passandogli il puntatore alla lista, ritorna 1 se riesce, -1 se fallisce
int scrivi_finale(t_lista **p)
{
	FILE *f;
	int i = 0;
	printf("Funzione in esecuzione: %s\n", __FUNCTION__);
	if((f = fopen("finale", "wb")))
	{
		//scorriamo la lista e scriviamo nel file finale
		while((*p)->prox != NULL)
		{
			fwrite(&((*p)->info),sizeof(t_datofinale), 1, f);
			printf("\nHo scritto la %d° struttura:\n", i++);
			print_struttura((**p).info);
			(*p) = (*p)->prox;
		}
		fclose(f);
		return 1;
	}
	else
	{
		printf("Errore nell'apertura del file finale\n");
		return EXIT_FAILURE;
	}
}

//stampa la struttura passata
void print_struttura(t_datofinale x)
{
	int i;
	printf("*****************\nMinimo: %d\nMassimo: %d\nMedia: %f\nNomeord: ", x.minimo, x.massimo, x.media);
	for(i = 0; i < STRINGALEN; i++)
	{
		printf("%c ", x.nomeord[i]);
	}
	printf("\n*****************\n");
}