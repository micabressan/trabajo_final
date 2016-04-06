#include<iostream>

using namespace std;

char board[3][3];

void drawboard()
{
	for (int y = 0; y < 3; y = y + 1)
	{
		for (int x = 0; x < 3; x = x + 1)
		{
			cout << board[x][y];
		}
		cout << endl;
	}
}

void fillBoard()
{
	for (int y = 0; y < 3; y = y + 1)
	{

		for (int x = 0; x < 3; x = x + 1)
		{
			board[x][y] = 'x';
		}
		cout << endl;
	}
}

void takeTurn()
{
	while
	{
		int taketurninput;

	cin << taketurninput;

		if (taketurninput == 00)

		{
		put "x" on 00
		}


	int taketurninput

		cin << taketurninput

		if (taketurninput == 01)

		{
			put "x" on 01
		}

	int taketurninput

		cin << taketurninput

		if (taketurninput == 02)

		{
			put "x" on 02
		}

	int taketurninput

		cin << taketurninput

		if (taketurninput == 10)

		{
			put "x" on 10
		}

	int taketurninput

		cin << taketurninput

		if (taketurninput == 20)

		{
			put "x" on 20
		}

	int taketurninput

		cin << taketurninput

		if (taketurninput == )

		{
			cout << "x" on 00
		}













}

void aiTurn()

{
	board[rand() % 3];
}

{
	board[rand() % 3];
}

{if }


void main(){

	fillBoard();

	drawboard();
}