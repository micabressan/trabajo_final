#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h> 
#include <vector> 
#include <conio.h>
#include <Windows.h>
#include <cuda.h>
#include <device_functions.h>
#include <cuda_runtime_api.h>

#define BLOCK_DIM 1

__global__ void fun(float* inputMatrix, float* outputMatrix, int width, int height)
{
	__shared__ float temp[BLOCK_DIM][BLOCK_DIM];
	int xIndex = blockIdx.x * blockDim.x + threadIdx.x;
	int yIndex = blockIdx.y * blockDim.y + threadIdx.y;
	if ((xIndex < width) && (yIndex < height))
	{
		int idx = yIndex * width + xIndex;
		temp[threadIdx.y][threadIdx.x] = inputMatrix[idx];
	}
	__syncthreads();

	xIndex = blockIdx.y * blockDim.y + threadIdx.x;
	yIndex = blockIdx.x * blockDim.x + threadIdx.y;
	if ((xIndex < height) && (yIndex < width))
	{
		int idx = yIndex * height + xIndex;
		outputMatrix[idx] = temp[threadIdx.x][threadIdx.y];
	}
}

__host__ void printMatrixToFile(char* fileName, float* matrix, int width, int height)
{
	FILE* file = fopen(fileName, "wt");
	for (int y = 0; y < height; y++)
	{
		for (int x = 0; x < width; x++)
		{
			fprintf(file, "%.0f\t", matrix[y * width + x]);
		}
		fprintf(file, "\n");
	}
	fclose(file);
}
__host__ int main()
{
	int width = 0;
	int height = 0;
	printf("Enter quantity of columns:");
	scanf("%d", &width);
	printf("Enter quantity of rows ");
	scanf("%d", &height);

	int matrixSize = width * height;
	int byteSize = matrixSize * sizeof(float);
	float *inputMatrix = (float*)calloc(matrixSize, sizeof(float));
	float *outputMatrix = (float*)calloc(matrixSize, sizeof(float));
	for (int i = 0; i < matrixSize; i++) inputMatrix[i] = rand() % 10 + 3;

	printMatrixToFile("start.txt", inputMatrix, width, height);
	float* devInputMatrix;
	float* devOutputMatrix;

	cudaMalloc((void**)&devInputMatrix, byteSize);
	cudaMalloc((void**)&devOutputMatrix, byteSize);
	cudaMemcpy(devInputMatrix, inputMatrix, byteSize, cudaMemcpyHostToDevice);

	dim3 gridSize = dim3(width / BLOCK_DIM, height / BLOCK_DIM, 1);
	dim3 blockSize = dim3(BLOCK_DIM, BLOCK_DIM, 1);

	fun << <gridSize, blockSize >> >(devInputMatrix, devOutputMatrix, width, height);

	cudaMemcpy(outputMatrix, devOutputMatrix, byteSize, cudaMemcpyDeviceToHost);
	cudaFree(devInputMatrix);
	cudaFree(devOutputMatrix);

	printMatrixToFile("finish.txt", outputMatrix, height, width);

	free (inputMatrix);
	free (outputMatrix);

	return 0;
}