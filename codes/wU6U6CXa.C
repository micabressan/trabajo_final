/* Program to display the following pattern:
****
 ***
  **
   *
*/
#include<stdio.h>
#include<conio.h>

void main()
{
	int i, j, k;

	clrscr();

	for(i = 0; i<4; i++) {
		for(k = 0; k < i; k++)
			printf(" ");
		for(j = 4; j > i; j--)
			printf("*");
		printf("\n");
	}

	getch();
}