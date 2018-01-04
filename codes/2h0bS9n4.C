#include <stdio.h> 
#include <math.h> 
	
	int main(void){
	double sq ;
	int i ,y, met,k,j;
	i=1; 
	met=0; 

	scanf("%d",&k);
		while ( k >= met) { 
		y=2;
			sq==sqrt(i); 
			if (sq = floor(i)) { 
				met==met+1 ; 
				i++;
			} else {
				for (j=1;j<=sqrt(i);j++){
					while (i>1){
						if (i%y==0) {
						i = i/y;
						if ((i%y)==0) { 
						met++; 
						break;
						}
						}
					}
				}
				i++;
			}
				i++;
				met=0;
			
			}
		printf("%d\n" , i);
		return 0; 
	}