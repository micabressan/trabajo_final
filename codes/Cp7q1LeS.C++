/*input
1000000
0 7
1 6
0 3
2 4
3 0
3 2
4 0
5 6
2 6
6 6
*/

#include <iostream>
#include <stack>
#include <vector>
#include <utility>
#include <memory>

using namespace std;

/*template<typename T, typename... Args> // za asp.riteh 
std::unique_ptr<T> make_unique(Args&&... args)
{
    return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
}*/
unique_ptr<pair<int, stack<int>>> novi_unique(pair<int, stack<int>>& copy)
{
	return make_unique < pair<int, stack<int>> > (make_pair(copy.first, copy.second));
}

unique_ptr<pair<int, stack<int>>> novi_unique()
{
	return make_unique <pair<int, stack<int>>> ( make_pair(0, stack<int>()));
}

int main()
{
	int brAkcija;
	int rjesenje = 0;
	cin >> brAkcija;
	vector<  unique_ptr< pair<int, stack<int>> >  > snjegovic; // masa snjegovica i kuglice
	snjegovic.push_back(novi_unique());

	snjegovic[0]->second.push(0);
	for (int i = 1; i <= brAkcija; ++i)
	{
		int brSnjeg, masaKug; 
		cin >> brSnjeg >> masaKug;

		snjegovic.push_back(novi_unique(*(snjegovic[brSnjeg]))); // uvijek stvaramo novog snjegovica

		if(masaKug == 0)
		{
			snjegovic[i]->first -= snjegovic[i]->second.top();
			snjegovic[i]->second.pop();
		}
		else
		{
			snjegovic[i]->first += masaKug;
			snjegovic[i]->second.push(masaKug);
		}

		rjesenje += snjegovic[i]->first;

	}	
	cout << rjesenje;
	return 0;
}