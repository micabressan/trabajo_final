void compact(char *s)
{
	int i = 0;
	while (*(s + i) != 0) {
		if (*(s + i) > 57 || *(s + i) < 48) {
			int j = i;
			while (*(s + j) != 0) {
				*(s + j) = *(s + j + 1);
			}
		}
		i++;
	}

	return;
}