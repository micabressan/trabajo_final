#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char name;
    int r;
    int s;
    int matrix*;
} matrix_t;

matrix_t* LoadMatrix(int matrix_size){
    matrix_t *matice = malloc(sizeof(matrix_t));
    matice.name = '';
    matice.r = 0;
    matice.s = 0;
    matice->matrix = (int*) malloc(sizeof(int)*matrix_size);
    return matice;
}


int main(int argc, char **argv){
    
    int matrix_size = 18;
    int mat_count = 5;
    matrix_t *matrix_array =  malloc(sizeof(matrix_t) * mat_count);