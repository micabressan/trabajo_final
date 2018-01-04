#include <iostream>

using namespace std;

char n[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', }; // numbers on the gameboard.
char player = 'X'; // player symbol
int win = 0;

void choice()
{
    int a;
    cout << "Enter a number:" << endl;
    cin >> a;


    if (a == 1)
    {
        n[1] = player;
    }
    else if (a == 2)
    {
        n[2] = player;
    }
    else if (a == 3)
    {
        n[3] = player;
    }
    else if (a == 4)
    {
        n[4] = player;
    }
    else if (a == 5)
    {
        n[5] = player;
    }
    else if (a == 6)
    {
        n[6] = player;
    }
    else if (a == 7)
    {
        n[7] = player;
    }
    else if (a == 8)
    {
        n[8] = player;
    }
    else if (a == 9)
    {
        n[9] = player;
    }

    else
    {
        cout << "try again";
    }

}

void turn()
{
    if (player == 'X')
    {
        player = 'O';
    }
    else
    {
        player = 'X';
    }
}

void board()
{
    system("CLS");
    cout << "     |   |   " << endl; // gameboard start
    cout << "   " << n[1] << " | " << n[2] << " | " << n[3] << "  " << endl;
    cout << "  ___|___|___" << endl;
    cout << "     |   |   " << endl;
    cout << "   " << n[4] << " | " << n[5] << " | " << n[6] << "  " << endl;
    cout << "  ___|___|___" << endl;
    cout << "     |   |   " << endl;
    cout << "   " << n[7] << " | " << n[8] << " | " << n[9] << "  " << endl;
    cout << "     |   |   " << endl; // gameboard end
    cout << endl;
}

int main()
{
    board();

    while (win == 0)
    {
    choice();
    board();
    turn();
    }
    system("pause");
    return 0;
}