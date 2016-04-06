#include <stdio.h>

float alg_quadratico(float v[], int n) {
    float max_ate_agora = 0.0;
    float soma;
    int i;
    int u;

    for (i = 1; i < n + 1; ++i) {
        soma = 0.0;

        for (u = i; u < n + 1; ++u) {
            soma += v[u - 1];
            max_ate_agora = max_ate_agora > soma ? max_ate_agora : soma;
        }
    }

    return max_ate_agora;
}

int main() {
    float v[] = {10, 5, -15, 20, 50, -1, 3, -30, 10};

    printf("max = %f\n", alg_quadratico(v, 9));
    return 0;
}