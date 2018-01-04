#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 10

void InsertSort(int arr[]) {
    int i, j, key;

    for (i=1; i<N; i++) {
        key = arr[i];
        j = i-1;
        while (j >= 0 && arr[j] > key) {
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = key;
    }
}
void InsertSortDesc(int arr[]) {
    int i, j, key;

    for (i=1; i<N; i++) {
        key = arr[i];
        j = i-1;
        while (key > arr[j] && j >= 0) {
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = key;
    }
}

void main() {
    int data_acak[N], i, pilih, data1[N], data2[N];
    char lagi = 'y';
    long t1, t2;

    // Generate random integer
    printf("Random int : ");
    for (i=0; i<N; i++) {
        srand(time(NULL) * (i+1));
        data_acak[i] = rand() % 100 + 1;
        printf("%d ", data_acak[i]);
    }
    printf("\n");

    // Salin data
    for (i=0; i<N; i++) {
        data1[i] = data_acak[i];
        data2[i] = data_acak[i];
    }

    // Selection
    printf("Setelah sorting (asc) : ");
    time(&t1);
    InsertSort(data1);
    time(&t2);
    for (i=0; i<N; i++) {
        printf("%d ", data1[i]);
    }
    printf("\n");
    printf("Waktu : %ld\n", t2-t1);

    // Selection
    printf("Setelah sorting (desc): ");
    time(&t1);
    InsertSortDesc(data2);
    time(&t2);
    for (i=0; i<N; i++) {
        printf("%d ", data2[i]);
    }
    printf("\n");
    printf("Waktu : %ld\n", t2-t1);
}