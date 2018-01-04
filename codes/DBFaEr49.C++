#include "stdafx.h"
#include "iostream"
#include "string.h"
#include "stdio.h"

using namespace std;

int main()
{
	int n;
	char str1[100], temp;
	puts("Vvdedite stroku");
	gets_s(str1);
	n = strlen(str1);
	for (int i = 0; i < n; i++) {
		for (int k = i; k < n; k++) {
			if (str1[i] != ' ') {
				if (str1[k] != ' ') {
					if (str1[i] > str1[k]) {
						temp = str1[i];
						str1[i] = str1[k];
						str1[k] = temp;
					}
				}
			}
			else break;
		}
	}
	puts(str1);
	system("pause");
	return 0;
}