//Program to input two numbers and swap them.
#include<stdio.h>
#include<conio.h>

void main()
{
	int number_1, number_2;

	clrscr();

	printf("Enter two numbers: ");
	scanf("%d%d", &number_1, &number_2);

	number_1 = number_1 + number_2;
	number_2 = number_1 - number_2;
	number_1 = number_1 - number_2;

	printf("The swapped numbers are: %d %d", number_1, number_2);

	getch();
}