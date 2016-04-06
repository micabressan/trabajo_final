#include <iostream.h>
#include <conio.h>

void main()
{
	clrscr();
	unsigned short int n;
	cout << "Enter a positive integer to print its multiplication table: ";
	cin >> n;
	cout << "\nMultiplication Table for " << n << " is,\n";
	for (int i(1); i<=10; i++)
		cout << "\t" << n << " X " << i << " = " << n*i << endl;
	getch();
}