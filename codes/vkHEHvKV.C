#include<stdio.h>

int decToBin(int val, char biner[], int index) {
    if (val == 0) {
        if (index == 0) {
            biner[index] = 48;
            biner[index + 1] = '\0';
            
            return 1;
        } else {
            biner[index] = '\0';
            return index;
        }
    }

    int len = decToBin((val / 2), biner, (index + 1));

    biner[len - index - 1] = (val % 2) ? 49 : 48;

    return len;
}

int main() {
    char biner[100];
    
    for (int i = 0; i < 100; ++i) {
        decToBin(i, biner, 0);
        printf("%2d = %8s (base 2)\n", i, biner);
    }

    return 0;
}