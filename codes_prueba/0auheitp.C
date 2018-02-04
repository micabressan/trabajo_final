#include<stdio.h>

int main(){	
	printf("int---> %ld \n", sizeof(int));
	//sizeof returns long int (%ld)
	// this is how we write one printf command
	// now to print all sizes we will combile all the sizeof
	//like this:
	printf("unsigned int---> %ld \n signed int ---> %ld \n float ---> %ld \n char ---> %ld \n long int ---> %ld \n long long int ---> %ld", sizeof(unsigned int), sizeof(signed int), sizeof(float),sizeof(char), sizeof(long int), sizeof(long long int));
	return 0;
	}