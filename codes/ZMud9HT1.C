#include <stdio.h>
#include <conio.h>
#define ROW 4
#define COL 3

void main()
{
	int r, i, /*c[3] = { 0 },*/arr[ROW][COL] = { { 5, 2, 1 }, { 3, 4, 6 }, { 1, 2, 3 }, { 0, 1, 2 } };

	for (r = 0; r < ROW; r++)
	{
		for (i = 0; i < COL; i++)
		{
			printf("%3d", arr[ROW][COL]);
		}
		printf("\n");
	}
	_getch();
}