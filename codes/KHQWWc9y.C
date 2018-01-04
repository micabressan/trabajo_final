#include <stdio.h>
#include <conio.h>
#include <math.h>

void main() {
	int a, b, putere, radical;
	char c;

	printf("a= ");
	scanf_s("%d", &a);

	printf("b= ");
	scanf_s("%d", &b);

	printf("Ce operatie doriti sa se aplice? \n");
	
	c = _getche();

	switch (c) {
	case'+':printf("\n%d + %d = %d", a, b, a + b);
		break;
	case'-':printf("\n%d - %d = %d", a, b, a - b);
		break;
	case'*':printf("\n%d * %d = %d", a, b, a * b);
		break;
	case'/':printf("\n%d / %d = %d", a, b, a / b);
		break;
	case'^':printf("\n%d ^ %d = %d", a, b,putere=pow(a,b));
		break;
	case'%':printf("\n%d modulo %d= %d", a, b, a%b);
		break;
	default:printf("\nCaracter invalid!");
		break;
	}

	_getch();
}