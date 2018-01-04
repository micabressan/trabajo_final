#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char* inseriscistringa();
char** crearchivio(int*);
void liberamem(char **,int );
void riempiarchivio(char **, int );
void leggiarch(char **, int );

int main ()
{
char *stringa; char risposta; int dimarc,scelta;
char **archivio=crearchivio(&dimarc);
riempiarchivio(archivio,dimarc);
leggiarch(archivio,dimarc);
liberamem(archivio,dimarc);
}


char * inseriscistringa()
{
  char *stringa;
  int dim;
  printf("Da quanti caratteri sarà composta la stringa?\t");
  scanf("%d",&dim);
  stringa=calloc(dim,sizeof(char));
  printf("Inserisci la stringa\t");
  scanf("%s",stringa);

  
return stringa;
}

char** crearchivio(int * dim)
{
   char **archivio;  
   printf("Quanti elementi vuoi salvare nell'archivio?\t");
   scanf("%d",dim);
   archivio=calloc(*dim,sizeof(char *));
   return archivio;
}

void riempiarchivio(char **archivio, int dim)
{
int i;
for(i=0;i<dim;i++)
   archivio[i]=inseriscistringa();
}

void leggiarch(char **archivio, int dim)
{
int i;
for(i=0;i<dim;i++)
   printf("La parola in posizione [%d] dell'archivio è %s\n",i,archivio[i]);
}

void liberamem(char **archivio,int dim)
{
int i;
for(i=0;i<dim;i++)   
{free(archivio[i]);}
free(archivio);
}