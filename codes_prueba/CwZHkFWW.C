#include <stdio.h>

int main(void)
{
	int idade;
	float salario;

	scanf("%d", &idade);	//le a idade do cliente
	scanf("%f", &salario;)	//le o salario do cliente

	if (idade > 18) {	//o cliente eh maior de idade?
		if (salario >= 2000.00) { //o cliente posui renda maior ou igual a 2000 reais?
			printf("credito aprovado!\n");
		} else {
			printf("desculpe-nos, seu credito nao foi aprovado");
		}
	}
	return 0;
}