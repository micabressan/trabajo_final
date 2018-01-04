#include<stdio.h>
#include<stdlib.h>
#include<string.h>

main(){
	int i, tamanho;
	int cont=0;
	char ast='*';
	char x[50];
	char letra;
	gets(x);
	printf("escolha uma letra: ");
	scanf("%c",&letra);		
	tamanho = strlen(x);
	for(i=0; i<tamanho;i++){
		if(letra == x[i]){
			x[i]=ast;	
		}
	}

	puts(x);
	
}