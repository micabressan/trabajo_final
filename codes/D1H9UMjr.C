#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>



int **generateMarix(int row, int col);
int **createMarix(int row, int col);
void printMatrix(int **tab, int row, int col);
void *multiplyMatrix(void *arg);


	int freeRow;
	int matrixFirstRow;
	int matrixFirstCol;
	int matrixSecondRow;
	int matrixSecondCol;
	int threadCount;

	int **matrixFirst;
	int **matrixSecond;
	int **matrixResult;
	pthread_t * threadTab;
	void *retval;


pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int main(int argc, char **argv) 
{

	
	srand(time(NULL));
	
	
	
			
	
		if(argc != 6)
		{
			printf("Nieprawidlowa liczba argumentow.\n");
			printf("Schemat: nazwa A B C D E (tworzy macierze AxB oraz CxD oraz uruchamia program na E watkach!)\n");
		}
		else 
		{
			
			matrixFirstRow = atoi(argv[1]);
			matrixFirstCol = atoi(argv[2]);
			matrixSecondRow = atoi(argv[3]); 
			matrixSecondCol = atoi(argv[4]);
			threadCount = atoi(argv[5]);
			
			if(matrixFirstCol != matrixSecondRow)
			{
				printf("Szerokosc pierwszej macierzy rozna od wysokosci macierzy drugiej ! \n");
				printf("Nie mozna wykonac mnozenia!\n");
				return 0;
			}
			else if(threadCount < 1)
			{
				printf("Liczba watkow musi byc wieksza od 0\n");
				return 0;
			}
			
			matrixFirst = generateMarix(matrixFirstRow, matrixFirstCol);
			matrixSecond = generateMarix(matrixSecondRow, matrixSecondCol);
			matrixResult = createMarix(matrixFirstRow, matrixSecondCol);
			
			printf("Wylosowana macierz  A %dx%d", matrixFirstRow, matrixFirstCol);
			printMatrix(matrixFirst, matrixFirstRow, matrixFirstCol);
			printf("Wylosowana macierz  B %dx%d", matrixSecondRow, matrixSecondCol);
			printMatrix(matrixSecond, matrixSecondRow, matrixSecondCol);
			
			
			threadTab = (pthread_t *)malloc(threadCount * sizeof(pthread_t));
			
			for(int i = 0; i < threadCount; i++)
			{
				pthread_create(&threadTab[i], NULL, multiplyMatrix, i);
			}
			
			
			for(int i = 0; i < threadCount; i++)
			{
				pthread_join(threadTab[i], &retval);
			}
			
			printf("Otrzymana macierz A*B  %dx%d", matrixFirstRow, matrixSecondCol);
			printMatrix(matrixResult, matrixFirstRow, matrixSecondCol);
			
			free(matrixFirst);
			free(matrixSecond);
			free(matrixResult);
			free(threadTab);
				
		}
		
	

	
	
	
	return 0;
}


int **generateMarix(int row, int col) 
{
	int **tab = NULL;
	
	
	
	
	tab = (int **)malloc(row * sizeof(int *));
	
		for (int i = 0; i < row; i++)
			tab[i] = (int *)malloc(col * sizeof(int));
	
	

	
	for(int i = 0; i < row; i++)
	{
		for(int j = 0; j < col; j++)
		{
			tab[i][j] = rand()%2;
		}
	}
	
	return tab;
	
}

int **createMarix(int row, int col) 
{
	int **tab = NULL;
	
	
	
	
	tab = (int **)malloc(row * sizeof(int *));
	
		for (int i = 0; i < row; i++)
			tab[i] = (int *)malloc(col * sizeof(int));
	
	

	
	for(int i = 0; i < row; i++)
	{
		for(int j = 0; j < col; j++)
		{
			tab[i][j] = 0;
		}
	}
	
	return tab;
	
}


void printMatrix(int **tab, int row, int col)
{
	printf("\n");
	for(int i = 0; i < row; i++)
	{
		for(int j = 0; j < col; j++)
		{
			printf("%d ", tab[i][j]);
		}
		printf("\n");
	}
	
}

void *multiplyMatrix(void *arg)
{
	int currentRow;
	int id = arg;

	while(1)
	{
		pthread_mutex_lock(&mutex);
		if(freeRow >= matrixFirstRow)
		{
			pthread_mutex_unlock(&mutex);
			return NULL;
		}
		currentRow = freeRow;
		freeRow++;
		pthread_mutex_unlock(&mutex);
		printf("%d", id);
		for(int j = 0; j < matrixSecondCol; j++)
		{
		
			for(int k = 0; k < matrixFirstCol; k++)
			{
				
				if(matrixFirst[currentRow][k] && matrixSecond[k][j])
				{
					matrixResult[currentRow][j] = 1;
					break;
				}
				
			}
			
		}
	}
}