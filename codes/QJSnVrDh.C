/* 
Lab 2
Not HelloWorld
*/
#include <stdio.h>

int main(void){
	int input=0, number[5]={0,0,0,0,0};
	int x, count=0;
	
	printf("Input a number between 0 and 32,767:\n");
	scanf("%d", &input);
	
	for (x=10000;x>=10;x/10){
		number[count] = input/x;
		input = input%x;
		count++;
		}
	printf("%d   %d   %d   %d   %d", number[0], number[1], number[2], number[3], number[4]);

}