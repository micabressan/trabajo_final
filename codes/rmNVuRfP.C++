#include <iostream>
#include "Header.h"
#include <cstdlib>

using namespace std;

int main()
{
	cout << "Enter first element of list: \n";
	int head;
	cin >> head;
	list* temp = init(head);
	list* root = temp;
	for (;;)
	{
		cout << "Enter next element of list, or '0' for stop:\n";
		int next;
		cin >> next;
		if (next == 0) break;
		temp = addelem(temp, next);
	}
	listprint(root);
	if (root->field < 0)
	{
		root = deletehead(root);
	}
	deleteNegative(root);
	cout << endl;
	listprint(root);
	system("pause");
}