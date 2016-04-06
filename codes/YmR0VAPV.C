//Program to input a number and check if it's even or odd.
#include<stdio.h>
#include<conio.h>

void main()
{
	int number;

	clrscr();

	printf("Enter a number: ");
	scanf("%d", &number);

	if(number % 2 == 0)
		printf("The number %d is even.", number);
	else
		printf("The number %d is odd.", number);

	getch();
}