#include <stdio.h>
#include <stdlib.h>
typedef struct {
    char name;
    int r;
    int s;
    int matrix**;
} matrix_t;

int main(int argc, char **argv){
    
    int arr_size = 5;
    matrix_t *matrix_array =  malloc(sizeof(matrix_t) * arr_size);