#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct node_st{
	char slovo;
	struct node_st * next;
}node;

void push(node ** head,char slovo){
	node * cvorKojiDodajemo=(node*)malloc(sizeof(node));
	cvorKojiDodajemo->slovo=slovo;
	cvorKojiDodajemo->next=NULL;
	if(*head==NULL){
		*head=cvorKojiDodajemo;
		return;
	}
	
	cvorKojiDodajemo->next=*head;
	*head=cvorKojiDodajemo;
}

char pop(node ** head){
	if(*head==NULL){
		printf("Stek je prazan");
		return '\0';
	}
	node * a=*head;
	*head=(*head)->next;
	return a->slovo;
}

void ubaciUStek(char string[], node ** stek){
	int i;
	while(string[i]!='\0'){
		push(stek,string[i]);
		i++;
	}

}

void palindrom(char string[]){
	node * stek= NULL;
	ubaciUStek(string,&stek);
	int i=0;
	int flag=1;
	for(i=0;i<strlen(string);i++){
		if(pop(&stek)!=string[i]){
			flag=0;
		}
	}
	if(flag==1){
		printf("jeste palindrom");
	}
	else{
		printf("nije palindrom");
	}

}

int main(){
	node * stek=NULL;
	push(&stek,'j');
	push(&stek,'o');
	push(&stek,'v');
	push(&stek,'a');
	push(&stek,'n');
	char c;
	do{
		c=pop(&stek);
		printf("%c",c);	
	}while(c!='\0');
	palindrom("gana");	
	return 0;


}