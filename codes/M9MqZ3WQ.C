#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>

typedef struct stos
{
	float re, im;
	struct stos *prev;
}stos;

void push (stos **top, float rez, float imz)
{
	stos *nowy;
	nowy = (stos *)malloc(sizeof(stos));
	nowy->re = rez;
	nowy->im = imz;
	nowy->prev=NULL;
	if (*top == NULL)
		*top = nowy;
	else 
	{
		nowy->prev=*top;
		*top = nowy;    // tu jest cos namieszane
	}	
}

void pop(stos **top)
{
	stos *tmp;
	tmp = (stos *)malloc(sizeof(stos));
	if (*top == NULL)
		printf("Stos pusty.\n");
	else
	{
		(int)(*top)->re = NULL; 
		(int)(*top)->im = NULL;
		(*top) = (*top)->prev;
	}
}
void delete(stos **top)
{
	stos *tmp;
	tmp = (stos *)malloc(sizeof(stos));
	if (*top == NULL)
		printf("Stos pusty.\n");
	else
		(*top) = NULL;

}
void show(stos *top)
{
	if (top == NULL)
		printf("\nStos jest pusty.\n");
	while (top!=NULL)
	{
		if (top->im < 0)
			printf("%f%fi\n", top->re, top->im);
		else
			printf("%f+%fi\n", top->re, top->im);
		top=top->prev;
	}
}

void dodawanie(stos **top)
{
	float re[2], im[2];
	re[0] = (*top)->re;
	im[0] = (*top)->im;
	*top = (*top)->prev;
	re[1] = (*top)->re;
	im[1] = (*top)->im;
	(*top)->re = re[0] + re[1];
	(*top)->im = im[0] + im[1];
}

void odejmowanie(stos **top)
{
	float re[2], im[2];
	re[0] = (*top)->re;
	im[0] = (*top)->im;
	*top = (*top)->prev;
	re[1] = (*top)->re;
	im[1] = (*top)->im;
	(*top)->re = re[0] - re[1];
	(*top)->im = im[0] - im[1];
}

void mnozenie(stos **top)
{
	float re[2], im[2];
	re[0] = (*top)->re;
	im[0] = (*top)->im;
	*top = (*top)->prev;
	re[1] = (*top)->re;
	im[1] = (*top)->im;
	(*top)->re = re[0] * re[1];
	(*top)->im = im[0] * im[1];
}

void dzielenie(stos **top)
{
	float re[2], im[2];
	re[0] = (*top)->re;
	im[0] = (*top)->im;
	*top = (*top)->prev;
	re[1] = (*top)->re;
	im[1] = (*top)->im;
	if (re[1] != 0 || im[1] != 0)
	{
		(*top)->re = re[0] / re[1];
		(*top)->im = im[0] / im[1];
	}
	else
		printf("Nie można wykonac dzielenia przez 0. Wartosci top zostaly usuniete. \n");
}

int main ()
{
	int option=0;
	float rez, imz;
	stos *stack = NULL, *tmp = NULL;
	char znak, c;
	while(option!=6)
	{
		printf("\n1.Push \n2.Show \n3.Pop \n4.Delete \n5.Operacje na liczbach. \n6.END\n\n");
		//scanf("%d",&option);
		while (scanf_s("%d", &option) != 1)
		{
			while ((c = getchar()) != '\n' && c != EOF);
			printf("Wybierz polecenie ponownie: \n");
		}
		switch(option)
		{
		case 1: 
			printf("Podaj wartosc Re oraz Im: ");
			//scanf("%f %f", &rez, &imz);				
			while (scanf_s("%f", &rez) != 1 || scanf_s("%f", &imz) != 1)
			{
				while ((c = getchar()) != '\n' && c != EOF);
				printf("Okresl wartosci ponownie (nie znak):  \n");
			}
			push(&stack,rez, imz);break;
		case 2:
			printf("Wyswetlam stos od gory: \n");
			show(stack); break;
		case 3: 
			printf("Usuwanie ze stosu: \n");       
			pop(&stack);				
			printf("Usunieto ostatni element.\n"); 
			show(stack);  break;				
		case 4: 	
			delete(&stack); 
			show(stack);  break;
		case 5: 
			printf("wybierz:\n+ Dodawanie \n- Odejmowanie \n* Mnożenie \n/ Dzielenie \n");
			scanf("%s", &znak);
			switch (znak)
			{
			case '+':
				dodawanie(&stack);
				show(stack); break;
			case '-':
				odejmowanie(&stack);
				show(stack); break;
			case '*':
				mnozenie(&stack);
				show(stack); break;
			case '/':
				dzielenie(&stack);
				show(stack); break;
			}break;
		case 6: 
			option = 6;break;
		default: break;
		}
    }
    system("pause");
    return 0;
}