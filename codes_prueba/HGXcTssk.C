//Program to input a number and check if it's Armstrong.
#include<stdio.h>
#include<conio.h>

void main()
{
	int number, sum = 0, temp;

	clrscr();

	printf("Enter number: ");
	scanf("%d", &number);

	temp = number;

	while(number != 0) {
		sum = sum + ((number % 10) * (number % 10) * (number % 10));
		number = number / 10;
	}

	if(sum == temp)
		printf("The number %d is an Armstrong number.", temp);
	else
		printf("The number %d is not an Armstrong number.", temp);

	getch();
}