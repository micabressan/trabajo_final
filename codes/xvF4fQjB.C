//Program to input a number and print it's reverse.
#include<stdio.h>
#include<conio.h>

void main()
{
	int number;

	clrscr();

	printf("Enter number: ");
	scanf("%d", &number);
	printf("The reverse of the number %d is: ", number);

	while(number != 0) {
		printf("%d", number % 10);
		number = number / 10;
	}

	getch();
}