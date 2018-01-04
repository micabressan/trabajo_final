int main()
{
	int a, b;
	scanf("%d %d", &a, &b);

	if (a > b)
	{
		a ^= b;
		b ^= a;
		a ^= b;
	}

	for (int i = b; i > a; i--)
	{
		for (int j = 2; j <= (i >> 1); j++)
		{
			if (i % j == 0)
				goto endI;
		}
		printf("%d\n", i);
		endI:
		continue;
	}
  return 0;
}