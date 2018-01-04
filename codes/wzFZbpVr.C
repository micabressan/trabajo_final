char* sReplace(char* s1, int k, char* s2, char* s3)
{
	int dif = sLength(s2) - sLength(s3);

	if (dif > 0)
		s1 = deleteSpot(s1, k, dif);
	else if (dif < 0)
		s1 = addSpot(s1, k, abs(dif));

	for (int i = k, z = 0; s3[z]; i++, z++)
		s1[i] = s3[z];

	return s1;
}

char* addSpot(char* s1, int k, int z)
{
	char* newS = new char[256];
	int i, j;
	z++;

	for (i = 0, j = 0; s1[i]; i++, j++)
		if (i < k || i > k)
			newS[j] = s1[i];
		else if (i == k)
		{
			for (int m = 0; m < z; m++, j++)
				newS[j] = ' ';
			j--;
		}

	newS[j] = '\0';

	return newS;
}

char* deleteSpot(char* s1, int k, int z)
{
	for (int i = 0; i < z; i++)
		for (int m = k; s1[m]; m++)
			s1[m] = s1[m + 1];
	return s1;
}