#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PEAK "PEAK"

int peak (int *arr, int i,int j, int n)
{
    int count = 0;
    while (i<=j) {
        if (((i == 0) && (arr[i] >= arr[i + 1])) || ((i == n - 1) && (arr[i] >= arr[i - 1]))) {
            count++;
        }
        if (i != 0 && i != n - 1 && arr[i - 1] <= arr[i] && arr[i + 1] <= arr[i]) {
            count++;
        }
        i++;
    }
    return count;
}

int query(int l, int r, int i, int a, int b, int *T)
{
    if  (l == a && r == b){
        return T[i];
    }else{
        int m = (a+b)/2;
        if (r <= m){
            return query(l, r, 2*i+1, a, m, T);
        }else{
            if (l > m){
                return query(l, r, 2*i+2, m+1, b, T);
            }else{
                return query(m+1, r, 2*i+2, m+1, b, T) + query(l, m, 2*i+1, a, m, T);
            }
        }
    }
}

void build(int *arr, int i, int n, int a, int b, int *T)
{
    if (a == b) {
        T[i] = peak(arr, a, b, n);
    }else{
        int m = (a+b)/2;
        build(arr, 2*i + 1, n, a, m, T);
        build(arr, 2*i + 2, n, m+1, b, T);
        T[i] = T[2*i + 2] + T[2*i+1];
    }
}


void update(int *arr, int j, int val, int i, int a, int b, int *T, int n)
{
    if (a == b)
        T[i] = peak(arr, a, b, n);
    else {
        int m = (a+b)/2;
        if (j <= m) {
            update(arr, j, val, 2*i+1, a, m, T, n);
        }else{
            update(arr, j, val, 2*i+2, m+1, b, T, n);
        }
        T[i] = T[2*i + 2] + T[2*i+1];
    }
}

int main()
{
    int n, l, r, times;
    scanf("%d", &n);
    int *arr = malloc(n * sizeof(int));
    int *T = malloc(4*n * sizeof(int));
    for (int i = 0; i < n; i++){
        scanf("%d", &arr[i]);
    }
    build(arr, 0, n, 0, n-1, T);
    scanf("%d", &times);
    char s[5];
    for (int i = 0; i < times; i++) {
        scanf("%s", &s);
        if (strcmp(s, PEAK) == 0) {
            scanf("%d%d", &l, &r);
            printf ("%d\n", query(l, r, 0, 0, n-1, T));
        }else{
            scanf("%d%d", &l, &r);
            arr[l] = r;
            update(arr, l, r, 0, 0, n-1, T, n);
            if (l!=0) update(arr, l-1, r, 0, 0, n-1, T, n);
            if (l!=n-1) update(arr, l+1, r, 0, 0, n-1, T, n); 
        }
    }
    free(arr);
    free(T);
}