char* impl_strncat(char *dest, const char *src, size_t n)
{
	int iLlengthDest = strlen(dest);
	int iLlengthSrc = strlen(src);

	// create new array for both arrys
	char* result = (char*) calloc((iLlengthDest + iLlengthSrc), sizeof(char));
	
	// copy dest
	for (int i = 0; i < iLlengthDest; i++)
	{
		result[i] = dest[i];
	}

	// copy src
	for (int i = 0; i < iLlengthSrc; i++)
	{
		result[i + iLlengthDest] = src[i];
	}

	for (int i = 0; i < (iLlengthDest + iLlengthSrc); i++)
	{
		printf("%c \n", result[i]);
	}

	result[iLlengthDest + iLlengthSrc] = '\0';
	dest = result;
	printf("%s", dest);
	return dest;
}