/*Nathalia Carpenedo Ferrari - 243738
Introdução a Programação: 3-B*/
#include <stdio.h>
#include <stdlib.h>

int main()
{
    float a1, a2, a3, media;                     //altura e média das alturas
    int menores=0;                               //quantidade de valores menores que 1.5

    printf("Digite a altura da pessoa 1: ");     //recebe as três entradas das medias
    scanf("%f", &a1);

    printf("Digite a altura da pessoa 2: ");
    scanf("%f", &a2);

    printf("Digite a altura da pessoa 3: ");
    scanf("%f", &a3);

    if(a1<1.5)                                  //caso a altura seja menor que 1.5, adiciona no contador
        menores++;

    if(a2<1.5)
        menores++;

    if(a3<1.5)
        menores++;


    printf("O Numero de pessoas com mais de 1.5 eh: %d\n", 3-menores);  //o numero total de pessoas é 3, logo, o número de maiores é 3-menores, e mostra o numero de maiores que 1.5
    printf("O Numero de pessoas com menos de 1.5 eh: %d\n", menores);   //mostra o numero de menores que 1.5

    media = (a1+a2+a3)/3;                                         //calcula a media aritimética

    printf("A media das alturas eh: %.2f\n", media);              //mostra a média

    if(media>1.5)                                                 //caso a média seja maior que 1.5, mostra uma mensagem de maior
        printf("A media das alturas é maior que 1.5\n");
        else
            printf("A media das alturas é menor que 1.5\n");       //caso a média seja menor, monstra uma mensagem de menor



    return 0;
}