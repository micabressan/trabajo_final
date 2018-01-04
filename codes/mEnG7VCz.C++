
int wystapieniaLiter[26];
for(int i = 0; i < 26; i++) {
	wystapieniaLiter[i] = 0;
}

char c;
for(int i = 0; i < 200; i++) {
	c = tab[i];
	wystapieniaLiter[c % 'a']++;
}

for(int i = 0; i < 26; i++) {
	if(wystapieniaLiter[i] > 1) {
		printf("%c wystapilo %d razy\n", i + 97, wystapieniaLiter[i]);
	}
}