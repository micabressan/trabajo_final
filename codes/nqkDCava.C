#include <stdio.h>
#include <stdlib.h>
 
    void wyswietlTablica(int* tab, int r)
{
    int i;
    for(i=0; i<r; i++)
    {
        printf("%d\t", tab[i]);
    }
    printf("\n");
}
 
void glowna(int* tab1, int* tab2, int r1, int r2)
{
    int i,r;
    int rozmiarTab=r;
    for(i=0;i<r;i++)
    {
        if(i==0)
        {
                int z;
                z=tab1[i];
                tab1[i]=tab2[i];
                tab2[i]=z;
        }
        else if(i%2==0)
        {
                int z;
                z=tab1[i];
                tab1[i]=tab2[i];
                tab2[i]=z;
        }
    }
 
 
}
 
void test1()
{
    printf("test1:\n");
    int tab1[]={};
    int tab2[]={};
    wyswietlTablica(tab1, 0);
    wyswietlTablica(tab2, 0);
    glowna(tab1,tab2, 0, 0);
    printf("Tablica po wypelnieniu:\n");
    wyswietlTablica(tab1, 0);
    wyswietlTablica(tab2, 0);
}
void test2()
{
    printf("test2:\n");
    int tab1[]={1,2,3,4,5,6,7,8};
    int tab2[]={9,10,11,12,13,14,15,16};
    wyswietlTablica(tab1, 8);
    wyswietlTablica(tab2, 8);
    glowna(tab1,tab2, 8, 8);
    printf("Tablica po wypelnieniu:\n");
    wyswietlTablica(tab1, 8);
    wyswietlTablica(tab2, 8);
}
void test3()
{
    printf("test3:\n");
    int tab1[]={1,2,3,4,5,6,7,8,9};
    int tab2[]={10,11,12,13,14,15,16,17};
    wyswietlTablica(tab1, 9);
    wyswietlTablica(tab2, 8);
    glowna(tab1,tab2, 9, 8);
    printf("Tablica po wypelnieniu:\n");
    wyswietlTablica(tab1, 8);
    wyswietlTablica(tab2, 9);
}
void test4()
{
    printf("test4:\n");
    int tab1[]={1,2};
    int tab2[]={3,4};
    wyswietlTablica(tab1, 2);
    wyswietlTablica(tab2, 2);
    glowna(tab1,tab2, 2, 2);
    printf("Tablica po wypelnieniu:\n");
    wyswietlTablica(tab1, 2);
    wyswietlTablica(tab2, 2);
}
void test5()
{
    printf("test5:\n");
    int tab1[]={1};
    int tab2[]={2};
    wyswietlTablica(tab1, 1);
    wyswietlTablica(tab2, 1);
    glowna(tab1,tab2, 1, 1);
    printf("Tablica po wypelnieniu:\n");
    wyswietlTablica(tab1, 1);
    wyswietlTablica(tab2, 1);
    }
 
int main()
{
 
    test1();
    test2();
    test3();
    test4();
    test5();
 
 
    return 0;
}