//Program to input temperature in Fahrenheit and convert into Celsius.
#include<stdio.h>
#include<conio.h>

void main()
{
	float temperature;

	clrscr();

	printf("Enter temperature in fahrenheit: ");
	scanf("%f", &temperature);
	printf("The temperature %f fahranheit in celsius is: %f", temperature, (temperature - 32) * 5 / 9);

	getch();
}