#include "stdafx.h"
#include "iostream"
#include "string.h"
#include "stdio.h"

using namespace std;

int main()
{
	int l, ds = 0, dmax = 0, pos = 0, n = 0, num;
	char str[100];
	puts("Vvedite stroku:");
	gets_s(str);
	l = strlen(str);

	for (int i = 0; i < l; i++){
		if (str[i] != ' ') ds++;
		else{
			if (ds>0) n++;
			if (ds > dmax){
				dmax = ds;
				pos = i - dmax + 1;
				num = n;
			}
			ds = 0;
		}
	}

	printf("\nNumber %d", num);
	printf("\nPosition %d", pos);
	system("pause");
	return 0;
}