/* letto un messaggio inserito dall'utente, il programma mi dice se il messaggio è palindromo. Uso i puntatori*/
#include<stdio.h>
#include<string.h>
#include <ctype.h>
#define MAX 50
int leggistringa(char *);
void palindromo(char*,int*, int);
void stampastringa(char *, int);
int main()
{
char stringa[MAX];
int palindr=0, dimensione=0;
dimensione=leggistringa(stringa);
stampastringa(stringa, dimensione);
palindromo(stringa,&palindr,dimensione);
if(palindr)
  printf("Il messaggio inserito è palindromo!\n");
else
 printf("Il messaggio inserito non è palindromo!\n");

}


void stampastringa(char *stringa, int dim)
{
printf("La stringa inserita è:\t");
char *p, *q;
p=stringa;
printf("%s",p);


}

int leggistringa(char *stringa)
{
char *p, *q;
p=stringa;
q=stringa+(MAX-1);
printf("Inserisci una messaggio:\t");
 for(p;p<q;p++)
     {
      scanf("%c",p);
      if(*p=='\n')
         break;      }
 return strlen(p);
}

void palindromo(char *stringa, int *palindromo, int dimstr)
{ 
char *p=stringa, *q=stringa+dimstr-1;
for(p;p<=q;p++,q--)
   {
    if(!isalpha(*p))
      {
       p++;
      }
     if(!isalpha(*q))
     {
      q++;
     }
     if(*p!=*q)
     break;
     }
if(p>=q)
*palindromo=1;
   }