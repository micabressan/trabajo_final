#include "stdafx.h"
#include <iostream>
#include <string>

using namespace std;

int main() {
	cout << "write number of words" << endl;
	int n;
	cin >> n;
	for (int i = 0; i<n; i++) {
		string s;
		cin >> s;
		for (int j = 0; j<s.size(); j++) {
			if (s[j] == 'b' && s[j + 1] >= '0' && s[j + 1] <= '9') continue; //удаление b
			if ((s[j] >= 'a' && s[j] < 'b') || (s[j] > 'b' && s[j] <= 'z')) continue; //удаление строчных букв
			cout << s[j];
		}
		cout << " ";
	}

	system("pause");
	return 0;
}