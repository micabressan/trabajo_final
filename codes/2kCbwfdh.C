#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include "greedy.h"
#include "ST.h"

typedef enum {
    false, true
} bool;

float **floatMatAlloc(int nr, int nc);
elements_t read(const char *fileName);
bool checkPartialResults(float *values, int sum, score_t *max);
void displaySol(int *sol, int dim, elements_t elements);
void genSol(int pos, int start, int k, int *sol, elements_t elem, score_t *max, float partial_sum, int *sum, int *bestSol, float *bestSum);
int *findSol(elements_t ele, score_t *max);
int calcOcc(elements_t elem, int *sol, int pos, float *values);
float checkBONUS(int *sol, int pos, elements_t elem);
void freeElements(elements_t elements);

int main(){
    elements_t elements;
    score_t max;
    int *sol;

    elements = read("elementi.txt");

    scanf("%f %f %f %f", &max.s_NA, &max.s_AA, &max.s_AI, &max.s_sum);

    printf("Searching a good solution with a fast greedy algorithm...\n");
    sol = findSolGreedy(elements, &max);
    displaySol(sol, MAX_ELEM, elements);
    free(sol);

    printf("\nSearching best solution with a slow recursive algorithm...\n");
    sol = findSol(elements, &max);
    displaySol(sol, MAX_ELEM, elements);
    free(sol);

    freeElements(elements);
    return 0;
}

elements_t read(const char *fileName){
    FILE *fp;
    elements_t elements = malloc(sizeof *elements);
    int i;
    float a, b;
    char BUFF[BUFFDIM];

    fp = fopen(fileName, "r");
    assert(fp != NULL);

    /*reading dimensions*/
    fscanf(fp, "%d%d%d\n", &elements->maxNA, &elements->maxAA, &elements->maxAI);
    elements->matDim = elements->maxNA + elements->maxAA + elements->maxAI;

    /*allocating matrix and symbol table*/
    elements->mat = floatMatAlloc(elements->matDim, MAT_NC);
    elements->st = STInit((unsigned int)elements->matDim);

    /*reading file*/
    for (i = 0; i < elements->matDim; i++){
        fscanf(fp, "%s%f%f\n", BUFF, &a, &b);

        elements->mat[i][1] = a;
        elements->mat[i][2] = b;

        /*inserting in st*/
        elements->mat[i][0] = STInsert(elements->st, BUFF);

        /*saving category*/
        elements->mat[i][3] = (i < elements->maxNA) ? CAT_NA : (i < elements->maxAA + elements->maxNA) ? CAT_AA : CAT_AI;
    }

    fclose(fp);
    return elements;
}

void freeElements(elements_t elements){
    int i;

    for (i = 0; i < elements->matDim; i++)
        free(elements->mat[i]);

    free(elements->mat);

    STFree(elements->st);
    free(elements);
}

float **floatMatAlloc(int nr, int nc){
    int i;
    float **mat;

    mat = malloc(nr * sizeof(float *));
    for (i = 0; i < nr; i++)
        mat[i] = calloc(nc, sizeof(float));

    return mat;
}

void displaySol(int *sol, int dim, elements_t elements){
    int i, occ;
    float sumTot = 0;

    for (i = 0; i < dim; i++){
        printf("%35s\t", STGet(elements->st, elements->mat[sol[i]][0]));

        if (i == 0 || sol[i] != sol[i - 1]){
            printf("+%.2f\t", elements->mat[sol[i]][2]);
            sumTot += elements->mat[sol[i]][2];
        } else 
            printf("+0.0\t");

        printf("\n");
    }

    printf("\tBest solution found:\t%.2f\n", sumTot + checkBONUS(sol, MAX_ELEM, elements));
}

int *findSol(elements_t ele, score_t *max){
    int *sol, *bestSol, i, sum = 0, occ;
    float bestRes = 0;

    sol = malloc(MAX_ELEM * sizeof *sol);
    bestSol = malloc(MAX_ELEM * sizeof *bestSol);

    for (i = 0; i < ele->matDim; i++)
        printf("%d) %30s\n", i, STGet(ele->st, ele->mat[i][0]));

    genSol(0, 0, MAX_ELEM, sol, ele, max, 0, &sum, bestSol, &bestRes);

    free(sol);
    return bestSol;
}

void genSol(int pos, int start, int k, int *sol, elements_t elem, score_t *max, float partial_sum, int *sum, int *bestSol, float *bestSum){
    int i;
    float sumTot;
    bool occ;

    if (pos >= k){
        sumTot = partial_sum + checkBONUS(sol, pos, elem);

        /*passed all checks, look at precedent best_sol, if this is better, it will be saved!*/
        if ((sumTot - *bestSum) > 0 && (sumTot - *bestSum) > (float)FLOAT_PRECISION){
            for (i = 0; i < pos; i++)
                bestSol[i] = sol[i];
            
            *bestSum = sumTot;
            *bestSum = roundf(*bestSum * FLOAT_PROX) / FLOAT_PROX;
        }

        return;
    }

    for (i = start; i < elem->matDim; i++){
        sol[pos] = i;

        if (checkPartialResults(elem->mat[i], *sum, max)){
            occ = calcOcc(elem, sol, pos, elem->mat[i]) == 1;
            
            if (occ)
                partial_sum += elem->mat[i][2];

            *sum += (int)elem->mat[i][1];

            genSol(pos + 1, start++, k, sol, elem, max, partial_sum, sum, bestSol, bestSum);

            /*backtrack*/
            if (occ)
                partial_sum -= elem->mat[i][2];

            *sum -= (int)elem->mat[i][1];
        }
    }
}

bool checkPartialResults(float *values, int sum, score_t *max){
    
    if (sum + (int)values[1] > max->s_sum)
        return false;
    
    switch((int)values[3]){
        case CAT_NA:
            return (values[1] <= max->s_NA);
        case CAT_AA:
            return (values[1] <= max->s_AA);
        case CAT_AI:
            return (values[1] <= max->s_AI);
    }
}

int calcOcc(elements_t elem, int *sol, int pos, float *values){
    int i, occ = 0;

    for (i = 0; i <= pos; i++)
        if ((int)elem->mat[sol[i]][0] == (int)values[0])
            occ++;

    return occ;
}

float checkBONUS(int *sol, int pos, elements_t elem){
    bool checkCAT[NUM_CAT] = { false };
    int i;
    float bonus = 0;

    for (i = 0; i < pos; i++)
        checkCAT[(int)elem->mat[sol[i]][3]] = true;

    /*checking last item for BONUS CAT n.2*/
    if (((elem->mat[sol[pos - 1]][3] == CAT_AA) || (elem->mat[sol[pos - 1]][3] == CAT_AI)) && (elem->mat[sol[pos - 1]][1] >= THING))
        bonus += BONUS_CAT;
    
    /*checking for BONUS CAT n.1*/
    if (((int)bonus == 0) && (checkCAT[CAT_NA] + checkCAT[CAT_AA] + checkCAT[CAT_AI] > 1))
        bonus += BONUS_CAT;
    else if (checkCAT[CAT_NA] && (checkCAT[CAT_AA] || checkCAT[CAT_AI]))
        bonus += BONUS_CAT;
    
    return bonus;
}