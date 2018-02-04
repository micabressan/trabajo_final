#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

char testando(char string[]){
int x, tam;
int cont=0;
char digite;
printf("escolha uma palavra \n");	
gets(string);
tam=strlen(string);
printf("Troque uma vogal por todas \n");
scanf("%c",&digite);	
for(x=0; x<tam; x++){
if(string[x]=='a'|| string[x]=='e' || string[x]=='i' || string[x]=='o' || string[x]=='u'){
cont++;	
}
	
 }
for(x=0; x<tam; x++){
if(string[x]=='a'|| string[x]=='e' || string[x]=='i' || string[x]=='o' || string[x]=='u'){
string[x]=digite;
}
} 
puts(string);	
}

	
	

 
 
 
 
 
main(){
 char teste[20];
 testando(teste); 
    
}