void nowef(char **a,int n)
{

	char** posortowana;
	posortowana = (char**)malloc(sizeof(char*) * n);

	for (int i = 0; i < n; i++)
	{
		posortowana[i] = a[i];
	}

	for (int j = 0; j < n; j++)
	{
		for (int i = 0; i < n - 1; i++)
		{
			if (strcmp(posortowana[i],posortowana[i+1])>0)
			{
				char *b = posortowana[i];
				posortowana[i] = posortowana[i + 1];
				posortowana[i + 1] = b;
			}
		}
	}

	for (int i = 0; i < n; i++)
	{
		printf("%s", posortowana[i]);
	}
}
void kolos1()
{
	char** b;
	b = (char**)malloc(sizeof(char*)*6);
	char t1[] = "ufo";
	char t2[] = "pies";
	char t3[] = "kot";
	char t4[] = "krowa";
	char t5[] = "samochod";
	char t6[] = "rower";
	b[0] = t1;
	b[1] = t2;
	b[2] = t3;
	b[3] = t4;
	b[4] = t5;
	b[5] = t6;
	
	nowef(b,6);
}