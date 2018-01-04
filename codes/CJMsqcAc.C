
void ex2()
{
	// Variable Definition
	char cpStr[] = "ABCDEFGH";
	//char cpStr[] = "ABCD";

	// Code Section

	printf("Old String:    %s\n", cpStr);

	// printf("New String Is: %s\n", ex2_ReOrderStr(cpStr));

	printf("New String Is: %s\n", ReturnAlktoni1(cpStr));
}

char *ex2_ReOrderStr(char *cpStr)
{
	// Variable Definition
	char *st = NULL;
	

	// Code Section

	// Condition to End The Recursion
	if (strlen(cpStr) == 2)
	{
		return cpStr;
	}

	// Create 
	st = calloc(strlen(cpStr) + 1, sizeof(char));

	st[0] = *cpStr;
	st[1] = *(cpStr + strlen(cpStr) - 1);

	// Shorting The cpStr by 1 In The End
	*(cpStr + strlen(cpStr) - 1) = '\0';

	// Coping After The First What Came Back From
	// The Recursion Call
	strcpy(st + 2, ex2_ReOrderStr(cpStr + 1));
	strcpy(cpStr, st);

	free(st);

	return cpStr;


	//cpStr[strlen(cpStr)] = st[1];
	//return cpStr;
}