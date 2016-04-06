/* Program to display the following pattern:
1
12
123
1234
12345
*/
#include<stdio.h>
#include<conio.h>

void main()
{
	int i, j;

	clrscr();

	for(i = 0; i<4; i++) {
		for(j = 0; j <= i; j++)
			printf("%d", j + 1);
		printf("\n");
	}

	getch();
}