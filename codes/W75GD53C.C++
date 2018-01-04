#include <iostream>
using namespace std;

int main()
{
	int max=0;
	for(int i=0;i<1000;i++)
	{
		if(i%2!=0&&i%3!=0&&i%5!=0&&i%7!=0) max =i;
	}
	cout<<"najwieksza liczba niepodzielna przez 2,3,5,7 ale mniejsza niz 1000 to: "<<max;
	
	cout<<"\n\n\t\tWcisnij 2x klawisz ENTER aby zakonczyc";
	cin.ignore();
	cin.get();
	return 0;
}