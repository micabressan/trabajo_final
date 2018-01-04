
int wystapieniaLiter[256];
for(int i = 0; i < 256; i++) {
	wystapieniaLiter[i] = 0;
}

char c;
for(int i = 0; i < 200; i++) {
	c = tab[i];
	wystapieniaLiter[c]++;
}

for(int i = 'a'; i < 'z'; i++) {
	if(wystapieniaLiter[i] > 1) {
		printf("%c wystapilo %d razy\n", i, wystapieniaLiter[i]);
	}
}