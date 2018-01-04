#include<stdio.h>
#include<stdlib.h>
#include<string.h>

main(){
	char x[50];
	char y[50];
	char w[50];
	int i, tam;
	printf("Nome: ");
	gets(x);
	tam = strlen(x);
	for(i=0;i<=tam;i++){
		y[0] = x[0];	
	}
	for(i=0;i<=tam;i++){
		if(x[i] == ' '){
		w[0] = x[+i+1];
		}	
	}
	printf("%s", y);
	printf("\n%s", w);
}