#include<stdio.h> 
#include<conio.h> 
#include<math.h> 
#define m 4 
#define n 4 

int main() 
{ 

	float B[m][n],A[m][n],B1[m][n],Bmin[m],P; 
	for (int i=0;i<m;i++) 
		for(int j=0;j<n;j++){ 
			printf("Input element number %iX%i\n",i+1,j+1); //вводим значение матрицы А.Это нужно для поиска max элементов главной диагонали 
			scanf("%f",&A[i][j]); 
			printf("Massiv A\n"); 
		} 
	for (int i=0;i<m;i++){ 
		for(int j=0;j<n;j++) 
			printf("%f\t", A[i][j]); 
		printf("\n"); 
		} 
	for (int i=0;i<m;i++) //начинаем поиск массива B 
		for(int j=0;j<n;j++) 
			B[i][j]=sin(i)-cos(j); 
	printf("Massiv B\n"); 
	for (int i=0;i<m;i++){
		for(int j=0;j<n;j++) 
			printf("%f\t ", B[i][j]); 
		printf("\n");
	} 
	for (int i=0;i<m;i++) //скопируем В 
		for(int j=0;j<n;j++) 
			B1[i][j]=B[i][j]; 
	for (int i=0;i<m;i++){		
		Bmin[i]=B[i][1]; 
		for(int j=0;j<n;j++){ 
			if(B[i][j]<Bmin[i]) 
				Bmin[i]=B[i][j]; 
		} 
	} 
	for (int i=0;i<m;i++){ 
		P=B1[i][i]; 
		B1[i][i]=Bmin[i]; 
		Bmin[i]=P; 
	}
	printf("Massiv B1\n"); 
	for (int i=0;i<m;i++){ //скопируем В 
		for(int j=0;j<n;j++)
			printf("%f\t ", B1[i][j]);  
		printf("\n");
	}
	getch(); 
	return 0; 
}