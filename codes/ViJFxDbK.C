struct b{
        int dlugosc;
        int *tab;
};

struct a{
        double wart;
        struct b *wsk;
};

void funkcja(struct a*pa);

int main(void){

        struct a pierwsza;
        struct b druga;
        int tablica[10]={1,2,3,4,5,6,7,8,9,10};
        druga.dlugosc=10;
        druga.tab=tablica;
        pierwsza.wsk=&druga;
        funkcja(&pierwsza);
        return 0;
}

void funkcja(struct a*pa){

        int dl, *tabl;
        dl=pa->wsk->dlugosc;
        tabl=pa->wsk->tab;
        printf("%d\n", tabl[dl-1]);
}