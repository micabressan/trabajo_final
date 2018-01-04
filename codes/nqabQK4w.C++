#include <bits/stdc++.h>
#include <string>
using namespace std;
typedef long long int llint;
int main()
{
	ios_base::sync_with_stdio(0);
	cin.tie(0);
	//cout << "Enter first string: "; 
	string str1; cin >> str1;
	//cout << "Enter second string: "; 
	string str2; cin >> str2;
	transform(str1.begin(),str1.end(),str1.begin(),::toupper);
	transform(str2.begin(),str2.end(),str2.begin(),::toupper);
	vector <long long> answers; answers.clear();
	unsigned long long persist = 0;
	while (true)
	{
		if (str1.find(str2,persist) == std::string::npos) break; //if not found
		llint position = str1.find(str2,persist);
		if (position != std::string::npos)
		{
			persist = position + str2.length();
			answers.push_back(position);
			//cout << position << '/' << persist << endl;
		};
	};
	//cout << "Found occurences: ";
	cout << endl;
	if (answers.empty()) return 0;
	for (llint i = 0 ; i <= answers.size() - 1 ; i++)
	{
		cout << answers[i] << ' ';
	}
}