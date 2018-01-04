#include <cstdio>

template <typename T>
void mergeSort (int *start, int *finish, T* buf, long long& k) {
    if (start != finish) {
        int * const l = start;
        int * const r = finish;
        int sz = 0;
        while (finish != start + sz) {
            sz++;
        }
        int *mid = start + sz / 2;
        mergeSort (start, mid, buf, k);
        mergeSort (mid + 1, finish, buf, k);
        int *z = buf;
        int x = 0, y = 0;
		int y_pushed = 0;
        while (start + x != mid + 1 && mid + y != finish) {
            if (*(start + x) <= *(mid + y + 1)) {
                *(z++) = *(start + (x++));
				k += y_pushed;
            }
            else{
                *(z++) = *(mid + 1 + (y++));
				y_pushed++;
            }
        }
        while (start + x != mid + 1) {
            *(z++) = *(start + (x++));
			k += y_pushed;
        }
        while (mid + y != finish) {
            *(z++) = *(mid + 1 + (y++));
        }

        for (int i = 0; start + i != finish + 1; ++i) {
            *(start + i) = *(buf + i);
        }

    }
}


int main () {
    int n;
	scanf("%d", &n);
    int *array = new int[n];
    int *buf = new int[n];
    for (int i = 0; i < n; ++i) {
        scanf ("%d", &array[i]);
    }
	
	long long k = 0;
	
    mergeSort (array, array + n - 1, buf, k);
	
	printf("%llu", k);

    delete[] buf;
    delete[] array;
    return 0;
}