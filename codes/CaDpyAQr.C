#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void cnt(void)
{
   FILE* in = fopen("input.txt", "r");
   int res = 0;
   int tmp = 0;

    while (!feof(in))
    {
        char c;

        fscanf(in, "%c", &c);

        if (!feof(in))
            if (c == ' ')
            {
                if (tmp == 101)
                  ++res;
                tmp = 0;
            }
            else if ('0' <= c && c <= '9')
                tmp = tmp *10 + c - '0';
            ///else figach oshibku
    }

    if (tmp == 101)
        ++res;

    printf("%d", res);
}

int main(void)
{
    cnt();
    return 0;
}