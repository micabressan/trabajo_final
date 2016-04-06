#include <stdio.h>
#include <stdlib.h>
#define ANOS 1
#define MESES 2 

typedef struct _inflacao 
{
float indice[MESES];
float acum;
} inflacao; 



int main () 
{
inflacao ano[ANOS];

int i,j; 

 
 
	printf("\nEntre com os dados da inflacao mensais de cada ano:"); 
 
// Entrada de Dados //  

	for (i=0; i < ANOS; i++)
	{
		printf("\n Ano %d:\n", (i+1) ); 
		
		for(j=0;j < MESES; j++)
		{
			
			printf("Mes %d:",(j+1)); 
			scanf("%f", &ano[i].indice[j] ); 
			
		
		}
		
		
	}
	
	
	
//Calculo das inflações//  

	for (i=0;i<ANOS;i++) 
	{
		ano[i].acum=1; 
		
		for(j=0;j<MESES;j++) {
			
			ano[i].acum = ano[i].acum * (1 + ano[i].indice[j]/100); 
						
		}
		
		ano[i].acum= (ano[i].acum-1)*100; 
	}
	
	
	
// Impressão de dados // 

 	for (i=0;i<ANOS;i++); 
 	{
 		printf("\nAno:%d\n",(i+1)); 
 		
 		for (j=0;j<MESES;j++); 
 		{
 			printf("Mes %d : %f\n",(j+1),ano[i].indice[j]); 
 		 
 				
 		}
 		
 		printf("Acumulado: %f",ano[i].acum);
 		
 	}
	
}