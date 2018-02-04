#include <stdio.h>
#include <stdlib.h>

int count(FILE *f){
	int prew, cur, inseq=0, c=0;
	fscanf(f, "%d", &prew);
	while(fscanf(f, "%d", &cur)==1){
		if(cur>prew){
			if(!inseq){
				c++;
				inseq=1;
				}
		}else{
			inseq=0;	
			}
		prew=cur;
	}
	return c;	
}


int main(void){
	char name[80];
	printf("enter filename:\n");
	scanf("%s",name);
	FILE *f = fopen(name, "r");
	printf("%d\n", count(f));
	fclose(f);
	return 0;
}