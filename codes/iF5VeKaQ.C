#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <ctype.h>

void clear(FILE * tekst)
{
	char c;
	int brojac = 1;
	for (int j = 0; j < brojac; j++)
		while ((c = fgetc(tekst)) != ')') if (c == '(') brojac++;
}

int citaj(FILE * tekst, char ** ime)
{
	char c;
	int brojac = 0;
	(*ime) = malloc(sizeof(char));
	while (isalpha(c = fgetc(tekst)))
	{
		(*ime)[brojac++] = c;
		(*ime) = realloc((*ime), (brojac + 1)*sizeof(char));
	}
	(*ime)[brojac] = '\0';

	if (c == '(') return 1;
	else if (c == ')') return 2;
	else return 0;
}

int biraj(FILE * tekst)
{
	char * ime = NULL;
	int mark;
	int random = rand() % 3;
//	printf("*%d*", random);
	for (int i = 0; i <= random; i++) {
		mark = citaj(tekst, &ime);
		if (mark && i != random)
		{
			clear(tekst);
			fgetc(tekst);
		}
	}
	if (mark == 1)
	{
		printf("%s ", ime);
		biraj(tekst);
		clear(tekst);
	}
	else if (mark == 0)
	{
		printf("%s", ime);
		clear(tekst);
	}
	else printf("%s", ime);
}

int main()
{
	srand(time(NULL));
	char c;
	FILE * ulaz = fopen("ulaz.txt", "r");
	if (ulaz == NULL) printf("abcd\n");

	while ((c = fgetc(ulaz)) != '.')
	{
		if (c == '(') biraj(ulaz);
		if (c != '(' && c != ')') printf("%c", c);
	}
	printf(".\n");
	fclose(ulaz);

	system("pause");
}