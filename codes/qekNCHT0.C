//Program to input two numbers and print the greater number.
#include<stdio.h>
#include<conio.h>

void main() 
{
	int number_1, number_2;

	clrscr();

	printf("Enter two numbers: ");
	scanf("%d%d", &number_1, &number_2);

	if(number_1 > number_2)
		printf("The greater number is: %d", number_1);
	else
		printf("The greater number is: %d", number_2);

	getch();
}