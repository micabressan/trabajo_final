/*-------------------------------------------------------------------------
  Include files:
--------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


/*=========================================================================
  Constants and definitions:
==========================================================================*/

/* put your #defines and typedefs here*/
void printOpenMessageForSodokoSize();
void printOpenMessageForSodokoSolution();
void printValidSolution();
void printBadSolution();



/*-------------------------------------------------------------------------
  The main program. (describe what your program does here)
 -------------------------------------------------------------------------*/
int root(int num){
    if(num == 0){
        return -1;
    }
    else if(num < 0){
        return -1;
    }
    else{
        double x = num - 0.1;
        int solution = 0;
        for(int i = 0; i < 100; i++){
            x = (x/2)+(num/(2*x));
        }
        if(x*x == num){
            solution = x;
            return solution;
        }
        else{
            return -1;
        }
    }
}


bool row_cheaker(int size, int a[][size]){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            for(int k = 0; k < size; k++){
                if(j == k){
                    continue;
                }
                else{
                    if(a[i][j] == a[i][k]){
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

bool col_cheaker(int size, int a[][size]){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            for(int k = 0; k < size; k++){
                if(j == k){
                    continue;
                }
                else{
                    if(a[j][i] == a[k][i]){
                        return false;
                    }
                }
            }
        }
    }
    return true;
}


bool square(int rectangle ,int size, int a[][size]){
    for(int m = 0; m < size; m = m + rectangle){
        for(int i = 0; i < rectangle; i++){
            for(int j = 0; j < rectangle; j++){
                for(int k = 0; k < rectangle; k++){
                    if((j + m) == (k + m)){
                        continue;
                    }
                    else{
                        if(a[i + m][j + m] == a[i + m][k + m]){
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

int main()
{
printOpenMessageForSodokoSize();
int sodoku_size = 1, rectangle = -1, soduko[sodoku_size][sodoku_size];
while(rectangle == -1){
    scanf("%d", &sodoku_size);
    rectangle = root(sodoku_size);
}
for (int i = 0; i < sodoku_size; i++)
    {
    for (int j = 0; j < sodoku_size; j++)
        soduko[i][j] = 0;
    }
    printOpenMessageForSodokoSolution();
    for(int k = 0; k < sodoku_size; k++){
       for(int m = 0; m < sodoku_size; m++){
            scanf("%d", &soduko[k][m]);
       }
    }
    if(row_cheaker(sodoku_size ,soduko[sodoku_size][sodoku_size]), col_cheaker(sodoku_size ,soduko[sodoku_size][sodoku_size]), square(rectangle ,sodoku_size ,soduko[sodoku_size][sodoku_size])){
       printValidSolution();
    }
    else printBadSolution();
    return 0;
}


void printOpenMessageForSodokoSize(){
    printf("Please enter the size of your soduko:\n");
}
void printOpenMessageForSodokoSolution(){
    printf("Please enter your solution:\n");
}
void printValidSolution(){
    printf("Valid solution!\n");
}
void printBadSolution(){
    printf("Bad solution!\n");
}