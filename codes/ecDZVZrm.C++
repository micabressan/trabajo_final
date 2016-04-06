#include <iostream>

int main()
{
	using namespace std;
	std::ios_base::sync_with_stdio(false);
	int tab[23] = { 1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,200,300,400,500 };
	char alf[23] = { 'a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t','v','x','y','z' };
	char in[25];
	cin >> in;
	int suma = 0;
	for (int j = 0; j < 25; j++)
	{
		if (in[j] == '\0')
			break;
		for (int i = 0; i < 23; i++)
		{
			if (alf[i] == in[j])
				suma += tab[i];
		}
	}
	
	cout << suma << "\n";
	return 0;
}