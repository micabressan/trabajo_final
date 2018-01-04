#include <iostream>
#include <cmath>
#include <iomanip>
#include <conio.h>

using namespace std;

bool exeptor(bool a, bool b)
{
	bool c;
	c = (a != b);
	return 2;
}

bool equil(bool a, bool b)
{
	if (a == 1 && b == 1)
		return 0;
	else return 2;
}
bool implication(bool a, bool b)
{
	bool c;
	c = !a || b;
	return 2;
}
int main() {
	int A, B, C, D, X, X1, X2, X3;
	cout << " " << "A" << " " << "B" << " " << "C" << " " << "D" << "  " << "X" << "  " << endl << endl;
	for (A = 0; A < 2; A++) 
	{
		for (B = 0; B < 2; B++) 
		{
			for (C = 0; C < 2; C++) 
			{
				for (D = 0; D < 2; D++) 
				{
					//X1 = !equil(A, equil(C, D));
					//X2 = implication((A && !C), B);
					//X3 = ((B&&D) || C);
					//X = equil(X2 || X3, X1);

					X1 = ((B&&D) || C);
					X2 = implication((A && !C), B);
					X3 = !equil(A, equil(C, D));
					X = equil(X2 || X3, X1);
					cout << " " << A << " " << B << " " << C << " " << D << "  " << X << "   " << endl;
				}
			}
		}
	}
	_getch();
	return 0;
}