#include <stdio.h> 
#include <math.h> 
	
	int main(void){
	double sq ;
	int i ,y, met,k;
	i=1; 
	met=0; 
	y=2;
	scanf("%d",&k);
		while ( k <= met) { 
			sq==sqrt(i); 
			if (sq = floor(i)) { 
				met==met+1 ; 
				i++;
			} else if ( i <= sqrt(i) ) { 
				if (i%y==0) {
					i = i/y;
					if ((i/y)==0) { 
					met++; 
					}else {
						met=0;
					}
				}
				i++;
			}else {
				met=0;
				i++; 
			}
		}
		printf("%d\n" , i);
		return 0; 
	}