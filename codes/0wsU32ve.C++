void delstr(char*s, int pos, int count) {
	int n = strlen(s);
	for (int i = 0; i <= n - (pos + count); i++)
		s[pos + i] = s[pos + count + i];
}