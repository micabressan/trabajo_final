bool are_coordinates_valid(int x, int y, int N)
{
	return x >= 0 && x < N && y >= 0 && y < N;
}

void compute_sum_of_neighbours(int tab[N][N], int neighoubrs_sum[N][N], int N) {
	d_x = {-1,0,1,-1,1,-1,0,1}
	d_y = {-1,-1,-1,0,0,1,1,1} 

	for (int x = 0; x < N; x++) 
	{
		for (int y = 0; y < N; y++)
		{
			for (int direction = 0; direction < 8; direction++)
			{
				if are_coordinates_valid(x + d_x[direction], y + d_y[direction])
				{
					neighoubrs_sum[x][y] += tab[x + d_x[direction]], [y + d_y[direction]];
				}
			}
		}
	}
}

int N;
int tab[N][N] = initialize();
int neighoubrs_sum[N][N] = zeros();

compute_sum_of_neighbours(tab, neighbours);