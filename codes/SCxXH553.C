#include <stdio.h>
#include <stdlib.h>

typedef struct{
    char name[100];
    int rating;
} show;

typedef struct{
    char name[100];
    show table[100];
} chanel;

void scan_show (show *x){
    scanf("%s%d", x->name, &x->rating);
}

void print_show (show *x){
    printf("\n\t%s %d", x->name, x->rating);
}

void scan_chanel (chanel *x){
    scanf("%s", &x->name);
    char buf[100];
    int n = 0;
    do{
        scanf("%s", buf);
        strcpy(((x->table)[n]).name, buf);
        if(strcmp(buf, "."))
            break;
        scanf("%d", ((x->table)[n]).rating);
        ++n;
    } while (1);
}

void print_chanel (chanel *x){
    printf("\n%s", x->name);
    for(int i = 0; ; ++i)
        if (!strcmp(((x->table)[i]).name, "."))
            print_show(&((x->table)[i]));
}

void scan_tv (chanel *tv, int n){
    for(int i = 0; i < n; ++i){
        scan_chanel(tv + i);
        print_chanel(tv + i);
    }
}

void print_tv (chanel *tv, int n){
    for(int i = 0; i < n; ++i)
        print_chanel(tv + i);
}

int main(){
    int n;
    scanf("%d", &n);
    chanel tv[n];
    scan_tv(tv, n);
    print_tv(tv, n);
}