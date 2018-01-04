// run as ./prog | aplay -r 44100
int buf[100],test;
int main() {
	for(;;) {
		if(test == 0)
			for(int i = 0; i < 100; i++)
				buf[i] = rand() & 255;
		test = 0;
		for(int i = 0; i < 100; i++) {
			int next = i == 99 ? 0 : i + 1;
			test |= buf[i];
			putchar(buf[i]);
			buf[i] = (buf[i] + buf[next]) * 63 / 128;
		}
	}
}