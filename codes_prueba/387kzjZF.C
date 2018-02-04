/*def algoritmo_quadratico(X):
    max_ate_agora = 0.0
    N = len(X)
    for L in range(1, N + 1):
        soma = 0.0
        for U in range(L, N + 1):
            soma = soma + X[U - 1]
            max_ate_agora = max(max_ate_agora, soma)
    return max_ate_agora

def lista_entrada(X):
    def algoritmo_divisao_e_conquista(L, U):
        if L > U:
            return 0.0
        if L == U:
            return max(0.0, X[L - 1])
           
        M = (L + U) / 2
        soma = 0.0
        max_a_esquerda = 0.0
        for I in range(M, 0, -1):
            soma = soma + X[I - 1]
            max_a_esquerda = max(max_a_esquerda, soma)
        soma = 0.0
        max_a_direita = 0.0
        for I in range(M + 1, U + 1):
            soma = soma + X[I - 1]
            max_a_direita = max(max_a_direita, soma)
        max_C = max_a_esquerda + max_a_direita
                   
        max_A = algoritmo_divisao_e_conquista(L, M)
        max_B = algoritmo_divisao_e_conquista(M + 1, U)
        return max(max_C, max_A, max_B)
    N = len(X)
    resposta = algoritmo_divisao_e_conquista(1, N)
    return resposta

def algoritmo_linear(X):
    max_ate_agora = 0.0
    max_terminando_aqui = 0.0
    N = len(X)
    for I in range(1, N + 1):
        max_terminando_aqui = max(0.0, max_terminando_aqui + X[I - 1])
        max_ate_agora = max(max_ate_agora, max_terminando_aqui)
    return max_ate_agora
*/

#include <stdio.h>

float max(float a, float b) {
    return a > b ? a : b;
}

float div_n_conquer_aux(float v[], int l, int u) {
    int m;
    int i;
    float soma;
    float max_a_esquerda;
    float max_a_direita;
    float max_A;
    float max_B;
    float max_C;

    if (l > u) {
        return 0.0;
    } else if (l == u) {
        return max(0.0, v[l - 1]);
    }

    m = (l + u) / 2;
    soma = 0.0;
    max_a_esquerda = 0.0;

    for (i = m; i > 0; --i) {
        soma += v[i - 1];
        max_a_esquerda = max(max_a_esquerda, soma);
    }

    soma = 0.0;
    max_a_direita = 0.0;

    for (i = m + 1; i < u + 1; ++i) {
        soma += v[i - 1];
        max_a_direita = max(max_a_direita, soma);
    }

    max_C = max_a_esquerda + max_a_direita;
    max_A = div_n_conquer_aux(v, l, m);
    max_B = div_n_conquer_aux(v, m + 1, u);

    return max(max(max_A, max_B), max_C);
}

float div_n_conquer(float v[], int n) {
    return div_n_conquer_aux(v, 1, n);
}

float linear(float v[], int n) {
    float max_ate_agora = 0.0;
    float max_terminando_aqui = 0.0;
    int i;

    for (i = 1; i < n + 1; ++i) {
        max_terminando_aqui = max(0.0, max_terminando_aqui + v[i - 1]);
        max_ate_agora = max(max_ate_agora, max_terminando_aqui);
    }

    return max_ate_agora;
}

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
    printf("max = %f\n", linear(v, 9));
    printf("max = %f\n", div_n_conquer(v, 9));
    return 0;
}