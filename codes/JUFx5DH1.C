#include <stdio.h>

int main(){
	int it,i,j,nl,net,nes;
	printf("Nombre de lignes ? (Nombre impair >= 3)");
	scanf("%d",&nl);

	/* haut */ 

	nes=(nl-1)/2;
	net=1;

	while(it<(nl/2)+1){

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
	net += 2;
	--nes;
	}


	/* bas */ 

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