#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void * p1, const void * p2) {
    int ree = *(char *)p1 - *(char *)p2;
    return ree;
}

int main()
{
    int i;
    char arr[1000];
    
    for (i = 0; i < 1000; ++i) {
        scanf("%c", &arr[i]);
        if (arr[i] == '.')
            break;
    }
    
    qsort(arr, i, sizeof(char), cmpfunc);
    
    for (int k = 0 ; k <= i; k++ ) {
        printf("%c", arr[k]);
    }
    return 0;
}