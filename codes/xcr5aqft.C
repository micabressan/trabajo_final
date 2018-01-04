#include<stdio.h>
#include<stdlib.h>
#include<string.h>

main(){
	char x[20];
	int i, tam, contP=0;
	char l;
	printf("Digite uma palavra: ");
	gets(x);
	tam = strlen(x);
	for(i=0;i<=tam;i++){
		if(x[i] == 'a'){
			contP++;
		}else if(x[i] == 'e'){
			contP++;
		}else if(x[i] == 'i'){
			contP++;
		}else if(x[i] == 'o'){
			contP++;
		}else if(x[i] == 'u'){
			contP++;
		}
	}
	printf("%d", contP);
	printf("\nAgora informe uma letra qualquer: ");
	scanf("%c", &l);
	for(i=0;i<=tam;i++){
		if(x[i] == 'a'){
			x[i] = l;
		}else if(x[i] == 'e'){
			x[i] = l;
		}else if(x[i] == 'i'){
			x[i] = l;
		}else if(x[i] == 'o'){
			x[i] = l;
		}else if(x[i] == 'u'){
			x[i] = l;
		}
	}
	puts(x);
}