#include <stdio.h>

int array_sum(int v[], int n, int i) {
    return i < n ? (v[i] + array_sum(v, n, i + 1)) : 0;
}

int main() {
    int v[] = {1, 2, 3, 4};

    printf("%i\n", array_sum(v, 4, 0));
}