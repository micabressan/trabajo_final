//Program to input a character and check if it's a vowel.
#include<stdio.h>
#include<conio.h>

void main()
{
	char ch;

	clrscr();

	printf("Enter an alphabet: ");
	scanf("%c", &ch);

	if(ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' || ch == 'A' || ch == 'E' || ch == 'I' || ch == 'O' || ch == 'U')
		printf("The alphabet %c is a vowel.", ch);
	else
		printf("The alphabet %c is not a vowel.", ch);

	getch();
}