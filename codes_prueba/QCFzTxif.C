#include <stdlib.h>
#include <stdio.h>

union change{
    int num;
    char bites[4];
};

union change2{
    int num_long;
    char bites[8];
};

int main(void)
{
    FILE *inp = fopen("matrix.in", "rb");
    FILE *outp = fopen("trace.out", "wb");

    int n;
    union change u;
    for(int l = 3; l != -1; l--)
        fread(&u.bites[l], sizeof(char), 1, inp);
    n = u.num;

    long long tr = 0;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            union change t;
            for(int l = 3; l != -1; l--)
                fread(&t.bites[l], sizeof(char), 1, inp);

            if(i == j)
                tr += t.num;
        }
    }

    union change2 v;
    v.num_long = tr;

    for(int i = 7; i != -1; i--)
        fwrite(&v.bites[i], sizeof(char), 1, outp);

    fclose(inp);
    fclose(outp);
    return 0;
}