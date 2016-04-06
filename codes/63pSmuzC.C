//BLEAK NUMBERS
#include <stdio.h>

int binaryOnes(int n)
{
	 int ones = 0;
	 while(n > 0)
	 {
  		ones += n % 2;
  		n = n / 2;
  	}

  	return ones;
}

int main(void) 
{
	int num, check, ones, flag = 0;

	scanf("%d", &num);

	check = num;

	while(check > 0)
	{
		check = check - 1;
		printf("\ncheck = %d", check);

		ones = binaryOnes(check);

		printf(" ones = %d", ones);


		if ((check + ones) == num)
		{
			flag = 1;
			printf("\nSUPPORTED");
			break;
		}

	}

	if(!flag) printf("\nBLEAK");

	return 0;
//1, 4, 6, 13, 15, 18, 21, 23, 30, 32, 37, 39, 46,… are bleak numbers
}