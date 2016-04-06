#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

int main()
{
	cout<<setprecision(10000);
	int n=0;
	long double wynik=0,liczba=0;
	cout<<"Podaj liczbe ";
	cin>>n;
	
	for(int i=0; i<=n; i++)
	{
		liczba =( pow( - 1.0, i ) ) /( 2 * i + 1);
		cout<<"Dla i= "<<i<<"   liczba="<<liczba<<endl;
		cout<<"Dla i= "<<i<<"  wynik+liczba   "<<wynik<<" + "<<liczba;
		wynik += liczba;
		cout<<" = "<<wynik<<endl<<endl;
	}
	
	getchar();getchar();
}