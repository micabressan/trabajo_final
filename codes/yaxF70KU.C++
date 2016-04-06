#include <iostream.h>
#include <conio.h>

int main()
{
	clrscr();
	unsigned short int n;
	bool prime(0);
	cout << "Enter a positive integer to check if its prime or not: ";
	cin >> n;
	if(n<=1)
		return 1;
	for (int i(2); i<n; i++)
		if(n%i==0)
		{
			prime = 1;
			break;
		}
	if(prime == 0)
		cout << "\nThe no. entered is Prime." << endl;
	else
		cout << "\nThe no. entered is NOT Prime." << endl;
	getch();
	return 0;
}