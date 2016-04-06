//Program to input base and height and calculate area of triangle.
#include<stdio.h>
#include<conio.h>

void main()
{
	float base, height;

	clrscr();

	printf("Enter base and height of the triangle: ");
	scanf("%f%f", &base, &height);
	printf("The area of triangle of base %f and height %f is: %f", base, height, 0.5 * base * height);

	getch();
}