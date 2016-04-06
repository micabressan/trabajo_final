/*
Faça um programa que lê um número inteiro n. O programa deve em seguida ler outros n números e guardá-los em um array. Assuma que o número n que usuário fornecer será no máximo 16.

    Imprima o maior e o menor valor fornecido pelo usuário
    Imprima um gráfico de barra dos valores fornecidos pelo usuário. Por exemplo: se o usuário fornecer 6 como o número n, e os números subsequentes forem 4 2 0 3 2 1, o programa deve imprimir:
    ^
    |*
    |*  *
    |** **
    |** ***
    |------>
*/

#include <stdio.h>

#define MAIOR(n1, n2) n1 > n2 ? n1 : n2
#define MENOR(n1, n2) n1 < n2 ? n1 : n2

void desenhaBarraInferior(int v){
     int i;
     printf("|");
     for(i = 0; i < v; i++){
     	printf("-");
     }
     printf(">");
}

int main(void){

	int n, i, j, maiorAux, *array, maior, menor;
	
	printf("Digite a quantidade de numeros: ");
	scanf("%d", &n);
	array = (int *) malloc(sizeof(int) * n);
	
	printf("Digite %d numero: ", n);
	
	for(i = 0; i < n; i++){
		scanf("%d", &array[i]);
		if(i == 0){
			maior = array[i];
			menor = array[i];
		}else{
			maior = MAIOR(maior, array[i]);
			menor = MENOR(menor, array[i]);
		}
	}
	maiorAux = maior;
	printf("^\n");
	for(i = 0; i < maior; i++){
		printf("|");
		for(j = 0; j < n; j++){
			if(array[j] == maiorAux){
			     printf("*");				
			     array[j]--;
			}else{
				printf(" ");
			}
		}
		puts("");
		maiorAux--;
	}
	desenhaBarraInferior(n);

	return 0;	
}