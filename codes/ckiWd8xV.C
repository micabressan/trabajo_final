#include <stdio.h>

int main(void)
{
	int idade;
	scanf("%d", &idade); // le a idade do paciente

	if (idade > 60) {
		printf("vacina liberada\n");
		return 0;  // encerra o programa
	}

	if (idade < 18) {
		printf("vacina liberada\n");
		return 0;  //encerra o programa
	}
	printf("vacina nao liberada\n");
	return 0;
}