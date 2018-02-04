#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <mpi.h>

double f(double x) {
	return 4 / (1 + x*x);
}

double integral(double left, double right, double dx) {
	double I=0, x;
        for (x = left; x < right; x += dx)
        {
            I += f(x) * dx;
        }
        return I;
}

int main (int argc, char *argv[])
{
	double dx, n=1000000000, width, left = 0, right = 1, partial_integral, sum, start_time, end_time;
	int myrank, size, i;

	MPI_Status Status;
	MPI_Request Request;
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

	start_time = MPI_Wtime();

	width = (right - left) / size;
	dx = width / n;

	if (myrank == 0)
	{
		sum = integral(left + myrank * width, left + (myrank + 1) * width, dx);
		for (i=1; i<size; i++)
		{
			MPI_Recv(&partial_integral, 1, MPI_DOUBLE, MPI_ANY_SOURCE, 1, MPI_COMM_WORLD, &Status);
			sum += partial_integral;
		}
		printf("pi = %f\n", sum);
		end_time = MPI_Wtime();
		printf("total time = %f\n", end_time - start_time);
	} else	{
		partial_integral = integral(left + myrank * width, left + (myrank + 1) * width, dx);
		MPI_Isend(&partial_integral, 1, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, &Request);
	}
	MPI_Finalize();
	return 0;
}