/*Program Kamila, przerobiony przez 
człowieka z "świetlaną przyszłością" w C :P */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX 100
#define EOS '\0'

int main()
{
    char napis[MAX], *wsk=napis;
    


    printf("Podaj jakis wyraz/ciag znakow: \n");
    gets(napis);

   while(*wsk++!=EOS)
		if(*wsk>96 && *wsk<123)
			*wsk-=32;
  
    puts(napis);

    return 0;
}