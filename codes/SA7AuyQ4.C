//Program to input basic salary and print gross salary.
#include<stdio.h>
#include<conio.h>

void main()
{
	float salary;

	clrscr();

	printf("Enter basic salary: ");
	scanf("%f", &salary);
	printf("The gross salary for the basic salary %f is: %f", salary, salary);

	getch();
}