#include <stdio.h>

int factorial(int n) {
    if (n >= 10) {
        return 0;
    }

    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
        result = result % 100;
    }

    return result;
}

void twoNumbersOfFactorial(int n, int *ones, int *tens) {
    int f = factorial(n);
    *ones = (f % 10);
    *tens = ((f % 100) / 10);
}

int main()
{
    int d;
    scanf("%d", &d);

    int n, tens, ones;
    for (int i = 0; i < d; i++) {
        scanf("%d", &n);
        twoNumbersOfFactorial(n, &ones, &tens);
        printf("%d %d\n", tens, ones);
    }

    return 0;
}