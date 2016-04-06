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
                        board[x][y] = '_';
                }
                cout << endl;
        }
}
 
void takeTurn()
{
	bool squareIsEmpty = false;
    while(!squareIsEmpty)
    {
		int taketurninputX, taketurninputY;
 
		cin >> taketurninputX >> taketurninputY;
		if(board[taketurninputX][taketurninputY] == '_')
		{
			squareIsEmpty = true;
			board[taketurninputX][taketurninputY] = 'x';
		}

	}
}
 
void aiTurn()
 
{
	bool squareIsEmpty = false;
    while(!squareIsEmpty)
    {
		int taketurninputX, taketurninputY;
		taketurninputX = rand() % 3;
		taketurninputY = rand() % 3;
		if(board[taketurninputX][taketurninputY] == '_')
		{
			squareIsEmpty = true;
			board[taketurninputX][taketurninputY] = 'o';
		}

	}
}
 

 
 
void main(){
 
        fillBoard();
 
        drawboard();
}