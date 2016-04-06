#include<stdio.h>
void main ()
{
    int row,col;
    int arr[5][4],avr[5];
    for(row=0;row<5;row++)
    {
        for(col=0;col<4;col++)
        {
            scanf("%d ",&arr[row][col]);
        }
        printf("\n");
    }
}