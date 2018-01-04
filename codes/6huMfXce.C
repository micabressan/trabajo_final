#include <stdio.h>

int main(){
	int it,i,j,nl,net,nes;
	printf("Nombre de lignes ? (Nombre impair >= 3)");
	scanf("%d",&nl);


	/* haut 

       *   		3 espaces - etoile    - 3 espaces
      ***  		2 espaces - 3 etoiles - 2 espaces
     ***** 		esapce    - 5 etoiles - espace
	*******     0		  - 7 etoiles - 0

	*/



	nes=(nl-1)/2;  /* hada nombre d'espaces f la ligne lowla */ 
	net=1;		   /* nombre d'etoiles f la ligne lowla */

	while(it<(nl/2)+1){ 	/* it = nombre d'itérations f partie haut */  

		for(j=0;j<nes;++j){  /* n7ot les espaces */ 
			printf(" ");
		}
		for(i=0;i<net;++i){  /* n7ot les etoiles */ 
			printf("*");
		}
		for(j=0;j<nes;++j){
			printf(" ");
		}
		printf("\n");

	++it;
	net += 2;
	--nes;
	}


	/* bas  


	
	 ***** 		esapce    - 5 etoiles - espace
	  ***		2 espaces - 3 etoiles - 2 espaces
       *		3 espaces - etoile    - 3 espaces



	*/

	it = 0;
	nes=1;
	net=nl-2;

	while(it<(nl/2)){

		for(j=0;j<nes;++j){
			printf(" ");
		}
		for(i=0;i<net;++i){
			printf("*");
		}
		for(j=0;j<nes;++j){
			printf(" ");
		}
		printf("\n");

	++it;
	net -= 2;
	++nes;
	}

	return 0;


}