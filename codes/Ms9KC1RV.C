#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct zapis{char znak,kod[11];}Zapis;

char *kodiraj(char *rec, Zapis *niz, int duz){

int i,len=strlen(rec),postoji=0;
char *rez;
rez=malloc(len*sizeof(char));

for(i=0;i<len;i++) {

for(j=0;j<duz;j++) {
if(rec[i]==niz[j].slovo) {postoji=1; break;}
}

if(postoji) {
for(t=0;t<strlen(niz[j].kod);t++){
if(k==len-1) {len+=2; rez=realloc(rez,len*sizeof(char));}

rez[k++]=niz[j].kod[t];}
}

else {

if(k==len-1) {len+=2; rez=realloc(rez,len*sizeof(char));}

rez[k++]=niz[i].kod;
}

}
return rez;
}


void main () {

int i=0,duz=10;
char *rec,c;

rec=malloc(duz*sizeof(char));
while(c=getchar()!='\n') {

if(i==duz-1){
duz+=2;
rec=realloc(rec,duz*sizeof(char));
}
rec[i++]=c;
}
rec[i]='\0';

if(i!=duz-1) rec=realloc(rec,(i+1)*sizeof(char));

duz=1; i=0;

niz=malloc(duz*sizeof(Zapis));

while(1){

c=getchar();

if(c=='\n') break;

if(i==duz-1) {duz+=2; 
niz=realloc(niz,duz*sizeof(Zapis));}

niz[i].znak=c;


scanf("%s",niz[i].kod);
i++;

c=getchar();
}

rez=kodiraj(rec,niz,duz);
printf("%s",rez);
}