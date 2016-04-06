#include <iostream>
using namespace std;

char ruut[10] = { 'o', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
int kontrolliv6it();
void laud();


int main()

{
	int m2ngija = 1, i, valik;
	char m2rgi;

	do

	{
		laud();
		cout << "M2ngija " << m2ngija << ", sisesta number:  ";
		cin >> valik;
		m2rgi = (m2ngija == 1) ? 'X' : 'O';

		if (valik == 1 && ruut[1] == '1')
			ruut[1] = m2rgi;
		else if (valik == 2 && ruut[2] == '2')
			ruut[2] = m2rgi;
		else if (valik == 3 && ruut[3] == '3')
			ruut[3] = m2rgi;
		else if (valik == 4 && ruut[4] == '4')
			ruut[4] = m2rgi;
		else if (valik == 5 && ruut[5] == '5')
			ruut[5] = m2rgi;
		else if (valik == 6 && ruut[6] == '6')
			ruut[6] = m2rgi;
		else if (valik == 7 && ruut[7] == '7')
			ruut[8] = m2rgi;
		else if (valik == 8 && ruut[8] == '8')
			ruut[8] = m2rgi;
		else if (valik == 9 && ruut[9] == '9')
			ruut[9] = m2rgi;
		else
		{
			cout << "Vale k2ik! ";
			m2ngija--;
			cin.ignore();
			cin.get();

		}
		i = kontrolliv6it();
			m2ngija++;

	} while (i == -1);
	laud();
	if (i == 1)
		cout << "==> M2ngija " << --m2ngija << "v6itis";
	else
		cout << "==> Viik!";
	cin.ignore();
		cin.get();
		return 0;

}

int kontrolliv6it()
{
	if (ruut[1] == ruut[2] && ruut[2] == ruut[3])
		return 1;
	else if (ruut[4] == ruut[5] && ruut[5] == ruut[6])
		return 1;
	else if (ruut[7] == ruut[8] && ruut[8] == ruut[9])
		return 1;
	else if (ruut[1] == ruut[4] && ruut[4] == ruut[7])
		return 1;
	else if (ruut[2] == ruut[5] && ruut[5] == ruut[8])
		return 1;
	else if (ruut[3] == ruut[6] && ruut[6] == ruut[9])
		return 1;
	else if (ruut[1] == ruut[5] && ruut[5] == ruut[9])
		return 1;
	else if (ruut[3] == ruut[5] && ruut[5] == ruut[7])
		return 1;
	else if (ruut[1] != '1' && ruut[2] != '2' && ruut[3] != '3' && ruut[4] != '4' && ruut[5] != '5' && ruut[6] != '6' && ruut[7] != '7' && ruut[8] != '8' && ruut[9] != '9')
		return 0;
	else
		return -1;
}


void laud()
{
	system("cls");
	cout << "Tips-Traps-Trull";
	cout << "M2ngija 1 (X)  -  M2ngija 2 (O)" << endl << endl;
	cout << endl;
	cout << "     |     |     " << endl;
	cout << "  " << ruut[1] << "  |  " << ruut[2] << "  |  " << ruut[3] << endl;
	cout << "_____|_____|_____" << endl;
	cout << "     |     |     " << endl;
	cout << "  " << ruut[4] << "  |  " << ruut[5] << "  |  " << ruut[6] << endl;
	cout << "_____|_____|_____" << endl;
	cout << "     |     |     " << endl;
	cout << "  " << ruut[7] << "  |  " << ruut[8] << "  |  " << ruut[9] << endl;
	cout << "     |     |     " << endl << endl;
}