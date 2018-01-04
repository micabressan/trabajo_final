#include <iostream>
#include <cstring>
using namespace std;

const size_t MAX = 100000000;

int main() {
	size_t SIZE = 8192;
	
	char* checked;
	checked = (char*)calloc(MAX,sizeof(char));
	
	unsigned int* primes;
	primes = (unsigned int*)malloc(SIZE*sizeof(unsigned int));
	
	unsigned int curr = 2;
	unsigned int pointer = 0;
	unsigned int i;
	
	while (curr<MAX) {
		//cout<<curr<<"\t";
		primes[pointer++] = curr;
		if (pointer >= SIZE) {
			SIZE<<=1;
			primes = (unsigned int*)realloc(primes,SIZE*sizeof(unsigned int));
			//cout<<"Reallocated to "<<SIZE<<" at "<<curr<<"\n";
		}
		for (i=curr; i<MAX; i+=curr) checked[i] = true;
		while (checked[curr]) curr++;
	}
	
	cout<<"\nLast prime is "<<primes[pointer-1]<<"\nTotal primes found: "<<pointer<<"\n";
	free(primes);
	free(checked);
}