#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
 
typedef struct {
    size_t length;
    int* lst;
}list;
 
void plot_hist(list *m, int hist, int min, int maxv);
 
int cmpfunc (const void * a, const void * b) {
    return ( *(int*)a - *(int*)b );
}
 
int int_dig(int n){
    int count = n > 0 ? 0 : 1;
    while(n != 0) {
        n /= 10;
        ++count;
    }
    return count;
}
 
//automatically scaling list
list* inputString(FILE *fp, size_t size){
    int *arr;
    int ch =0;
    size_t len = 0;
    arr = calloc(sizeof(int), size); //start size
    if(!arr){
        free(arr);
        return NULL;
    }
    int n, r = 1;
    while(ch != EOF && ch!='\n'){
        r = fscanf(fp, "%d", &n);
        if(r <= 0) break;
        ch=fgetc(fp);
        if(len==size) {
            arr = realloc(arr, sizeof(int) * (size += 16));
            if (!arr){
                free(arr);
                return NULL;
            }
        }
        arr[len++] = n;
    }
    arr = realloc(arr, sizeof(int) * len);
    if(!arr){
        free(arr);
        return NULL;
    }
    list *l = (list*) malloc(sizeof(list));
    l->lst = arr;
    l->length = len;
    return l;
}
 
int main(void){
    FILE *fp;
 
    fp = stdin;
 
    list *m;
    int n_hist;
    fscanf(fp,"%d ",&n_hist);
 
    m = inputString(fp, 10);
 
    qsort(m->lst, m->length, sizeof(int), cmpfunc);
 
    printf("Median %.2f\n", m->lst[(m->length)/2]/1.0);
    printf("Number count: %d\n", (int) m->length);
    printf("Min: %d\n", m->lst[0]);
    printf("Max: %d\n", m->lst[m->length-1]);
    printf("Histogram:\n");
 
    plot_hist(m, n_hist, m->lst[0], m->lst[m->length-1]);
     
    free(m->lst);
    free(m);
    return 0;
}
 
void plot_hist(list *m, int n_hist, int minv, int maxv) {
 
    double step = (maxv - minv)/(double)n_hist;
 
    int* histogram = calloc(sizeof(int), n_hist);
    int j = 0;
 
    int maxv_hist = 0;
 
    for (int i = 0; i <n_hist ; ++i) {
        while(j < m->length && m->lst[j] <= (minv + (i+1)*step)){
            histogram[i]++;
            j++;
        }
        if(histogram[i]>maxv_hist){
            maxv_hist = histogram[i];
        }
    }
 
    int maxv_s = int_dig(minv) > int_dig(maxv) ? int_dig(minv) +2 : int_dig(maxv)+2;

    maxv_s = maxv_s >= 4 ? maxv_s : 4;
 
    double scale = 25.0/maxv_hist;
 
        for (int i = 0; i < n_hist ; ++i) {
        printf("%*.1f - %*.1f|", maxv_s, minv+i*step, maxv_s, minv+(i+1)*step);
 
        for (int k = 0; k < (int)round(scale*histogram[i]); ++k) {
            printf("=");
        }
        printf("\n");
    }
    free(histogram);
}