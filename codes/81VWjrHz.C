#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define n 1000


int main(int argc, char *argv[]) {
	double time_start = MPI_Wtime();
	int array[n];
	int myrank, size;
	int sum,width,i,end;
	int result = 0;	
	MPI_Status Status;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
	printf("I am %d of %d\n",myrank,size);
	if (n%(size-1)==0){
		width = n/(size-1);
	}
	else{
		width = n/(size-1)+1;
	}
	end = n-width*(size-2);
	if (myrank == 0){
		for (i=0;i<n;i++){
			array[i]=i;			
		}
		
		for(i=0;i<size-2;i++){
			MPI_Send(&array[width*i],width,MPI_INT,i+1,1,MPI_COMM_WORLD);
		}
		MPI_Send(&array[width*(size-2)],n-width*(size-2),MPI_INT,size-1,1,MPI_COMM_WORLD);
	}

	else{
		if (myrank == size-1){		
			MPI_Recv(array,end,MPI_INT,0,1,MPI_COMM_WORLD,&Status);
			width = end;
		}
		else{
			MPI_Recv(array,width,MPI_INT,0,1,MPI_COMM_WORLD,&Status);
		}	
		for(i=0;i<width;i++){
			result+=array[i];
		}
	}
	MPI_Reduce(&result, &sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if (myrank == 0) {
		printf("result = %d\n", sum);
	}
	
	double time_end = MPI_Wtime();
	MPI_Finalize();
	if (myrank == 0) {
		printf("execution time = %f\n", time_end - time_start);
	}
	return 0;
}