#include <stdio.h>
#include <stdlib.h>
#define T 100
void espacamento(char palavra[T]);
int contar(char palavra[T]);
int main()
{
    char palavra[T];
    printf("Digite uma palvra: "); scanf("\n%[^\n]",palavra);

    espacamento(palavra);

    return 0;
}
int contar(char palavra[T])
{
    int i = 0;
    while(palavra[i] != '\0')
        i++;
    return i;
}

void espacamento(char palavra[T])
{
    char copia[T];
    int i=0, j = 0, tam;

    while(palavra[i] != '\0' )
    {
        copia[j] = palavra[i];
        copia[j+1] = ' ';
        j = j+2;
        i++;
    }
    printf("%s",copia);
}