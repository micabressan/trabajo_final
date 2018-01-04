#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<locale.h>

int posicao = 0;

struct cadastro{
	int codIden;
	char raca[20];
	char dataErtd[11];
	char sexo;
	int idade;
};

struct cadastro animais[5];

cadAnimal(){
	system("cls");
	int x, contsm=0, contsf=0 ;
	do{
		printf("\nRaça: ");
		fflush(stdin);
		gets(animais[posicao].raca);
		printf("\nData de entrada \"DD/MM/AAAA\": ");
		fflush(stdin);
		gets(animais[posicao].dataErtd);
		printf("\nSexo = M ou F: ");
		fflush(stdin);
		scanf("%c", &animais[posicao].sexo);
		if(animais[posicao].sexo == 'm'){
			contsm++;
		}if(animais[posicao].sexo == 'f'){
			contsf++;
		}
		printf("\nIdade: ");
		scanf("%d", &animais[posicao].idade);
		animais[posicao].codIden = posicao;
		posicao++;
		printf("\nCódigo Identificador do animal: #%d", posicao);
		printf("\n\nVoce deseja cadastrar outro animal? 1-SIM ou 0-NÃO:");
		scanf("%d", &x);
		printf("\n\n-----------------------------");
		system("cls");
	}while(x!=0);
		
}

pesquisar(){
	system("cls");
	int op;
	printf("\n2.1.Pesquisar por raça");
	printf("\n2.2. Pesquisar por sexo\n");
	scanf("%d", &op);
	
	switch(op){
		case 1:
			pesqraca();
		break;
		
		
	}
}

pesqraca(){
	struct cadastro animaisLocal[50];
	char x[20];
	int retorno, i,j=0, k;
	printf("Digite a raça desejada: ");
	fflush(stdin);
	gets(x);
	if(posicao>0){
	for(i=0; i<posicao; i++){
		retorno = strcmp(x, animais[i].raca);
		if(retorno == 0){
			animaisLocal[j] = animais[i];
			j++;
			}
		}
	}else{
		system("cls");
		printf("Não Há Animais Cadastrados!\n");
		system("pause");
		system("cls");
	}
	if(j>0){//Faz outro for pra printa a lista de animais encontrados usando a  variavel "animaisLocal"
		for(k=0;k<j;k++){
			printf("\nRaça: %s ", animaisLocal[k].raca);
			printf("\nDada de entrada: %s", animaisLocal[k].dataErtd);
			printf("\nSexo: %c", animaisLocal[k].sexo);
			printf("\nIdade: %d", animaisLocal[k].idade);
			printf("\nCódigo Indetificador: #%d\n\n", animaisLocal[k].codIden+1);
		}
		system("pause");
	}
}
pesqsexo(){
	struct cadastro idemLocal[50];
	char x;
	int retorno, i,j=0, k;
	printf("Digite o sexo desejado [m/f]: ");
	fflush(stdin);
	scanf("%c", &x);
	if(posicao>0){
	for(i=0; i<posicao; i++){
		retorno = x == animais[i].sexo;
		if(retorno == 0){
			idemLocal[j] = animais[i];
			j++;
			}
		}
	}else{
		system("cls");
		printf("Não Há Animais Cadastrados!\n");
		system("pause");
		system("cls");
	}
	if(j>0){//Faz outro for pra printa a lista de animais encontrados usando a  variavel "idemLocal"
		for(k=0;k<j;k++){
			printf("\nRaça: %s ", idemLocal[k].raca);
			printf("\nDada de entrada: %s", idemLocal[k].dataErtd);
			printf("\nSexo: %c", idemLocal[k].sexo);
			printf("\nIdade: %d", idemLocal[k].idade);
			printf("\nCódigo Indetificador: #%d\n\n", idemLocal[k].codIden+1);
		}
		system("pause");
	}
}


estatistica(){
	system("cls");
	int op;
	printf("\n3.1.Apresentar total de animais por sexo");
	printf("\n3.2.Apresentar a média de idade de animais por sexo\n");
	scanf("%d", &op);
	
	switch(op){
		case 1:
			totalsexo();
		break;
		
		case 2: 
			mediasexo();
	}
}

totalsexo(){
	char x;
	printf("Sexo desejado [m/f]: ");
	fflush(stdin);
	scanf("%c", &x);
	if(x == 'm'){
		system("cls");
		printf("Total de Machos: %d");
	}
	if(x == 'f'){
		printf("Total de Fêmeas: %d");
	}
}
mediasexo(){
	
}
main(){
	setlocale(LC_ALL, "Portuguese");
	int op;
	
	do{
		printf("\n\n>>Gerenciador do Zoológico<<\n\n1.Cadastrar animal\n2.Pesquisar\n3.Estatísticas\n4.Sair\n\n-------------------------------- OP = ");
		scanf("%d", &op);
	
		switch(op){
			case 1:
				cadAnimal();
			break;
		
			case 2:
				pesquisar();
			break;
			
			case 3:
				estatistica();
			break;
			
			case 4:
				exit(0);
			break;
			
			default:
				printf("Opção inválida!");
			}
	}while(op!=4);
}