#include <algorithm>
#include <iostream>

namespace FastIO {
	static char c, c2;
	static int top, buf[22];

	template<typename T> inline void read(T &x) {
		x = 0;
		for (c = getchar(), c2 = '.'; !isdigit(c); c2 = c, c = getchar()) {}
		for (; isdigit(c); c = getchar()) {
			x = x * 10 + c - '0';
		}
		if (c2 == '-') {
			x = -x;
		}
	}

	template<typename T> inline void write(T &x) {
		if (x < 0) {
			putchar('-');
			x = -x;
		}
		top = 0;
		for (; x || !top; x /= 10) {
			buf[++top] = x % 10;
		}
		for (; top; putchar(buf[top--] + 48)) {}
	}
}

using namespace std;
using namespace FastIO;

const int N = 1e6;

int n, a[N];

int main() {
	read(n);
	for (int i = 0; i < n; i++) {
		read(a[i]);
	}
	sort(a, a + n);
	for (int i = 0; i < n; i++) {
		write(a[i]);
		putchar(' ');
	}
	putchar('\n');
	return 0;
}