#include <iostream>
#include <vector>

const int N = 100000;
const int MAX = 1000000;
using namespace std;

int main() {
	unsigned int primes[N];
	primes[0] = 2;
	unsigned int found = 1;
	unsigned int curr = 3;
	bool add;
	unsigned int i;
	//while (found < N) {
	while (curr < MAX) {
		add = true;
		for (i=0; i<found; i++) {
			if (curr % primes[i] == 0) {
				add = false;
				break;
			}
			if ((primes[i]<<1)>curr) break;
		}
		if (add) {				
			primes[found] = curr;
			//cout<<curr<<'\t';
			found++;
		}
		curr+=2;
	}
	cout<<found;
}