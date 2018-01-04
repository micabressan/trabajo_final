for (k = 0; k < size - 1; k++)
#pragma omp parallel for schedule(static,1)
for (i = k + 1; i < size; i++) {
L[i][k] = M[i][k] / M[k][k];
for (j = k + 1; j < size; j++)
M[i][j] = M[i][j] - L[i][k]*M[k][j];
}