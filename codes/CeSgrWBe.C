//Program to input a number and calculate sum of it's digits.
#include<stdio.h>
#include<conio.h>

void main()
{
	int number, sum = 0;

	clrscr();

	printf("Enter number: ");
	scanf("%d", &number);

	while(number != 0)
	{
		sum = sum + (number % 10);
		number = number / 10;
	}

	printf("The sum of the digits of the number %d is: %d", number, sum);

	getch();
}