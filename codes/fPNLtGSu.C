#include <stdio.h>
#include <stdlib.h>

int prost(int br)
{
    int i=2;
    while (i<(br/2))
    {
        if ((br%i)==0) return 1;
        i++;
    }
    return 0;
}

int prostiCifri (int br)
{
    int sum=0;
    while (br>0)
    {
        sum+=(br%10);
        br/10;
    }
    return sum;
}

int main()
{
    int i;
    for (i=1; i<10000; i++)
    {
        if (!prost(i))
        {
            if (prost(prostiCifri(i))) printf("%d\t");
        }
    }
    return 0;
}