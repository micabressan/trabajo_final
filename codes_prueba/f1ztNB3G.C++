#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#define N 100
#define M 20

using namespace std;

struct Drzava
{
    char ime[20];
    int st;
    char glav[20];
};

void vpis(struct Drzava d[]);
void sorti(struct Drzava d[]);
void izpis(struct Drzava d[]);

int main()
{
    struct Drzava d[N];
    vpis(d);
    sorti(d);
    izpis(d);
    return 0;
}

void vpis(struct Drzava d[])
{
    for(int i=0;i<N;i++)
    {
        cout<<"Vnesite ime drzave: ";
        gets(d[i].ime);
        fflush(stdin);
        cout<<endl<<"Vnesite ime glavnega mesta: ";
        gets(d[i].glav);
        fflush(stdin);
        cout<<endl<<"Vnesite stevilo prebivalcev: ";
        cin>>d[i].st;
        fflush(stdin);
        for(;d[i].st<50000;)
        {
            cout<<"A to je drzava?"<<endl;
            cin>>d[i].st;
            fflush(stdin);
        }
        fflush(stdin);
    }
}

void sorti(struct Drzava d[])
{
    int pom=0;
    for(int i=0;i<N;i++)
    {
        for(int j=N-1;j>i;j++)
        {
            if(d[j-1]>d[j])
            {
                pom=d[j-1];
                d[j-1]=d[j];
                d[j]=pom;
            }
        }
    }
}

void izpis(struct Drzava d[])
{
    char pom[20];
    cout<<endl<<"Vnesite ime drzave";
    gets(pom);
    for(int i=0;i<N;i++)
    {
        if(pom=d[i].ime)
        {
            cout<<"Ime drzave je: ";
            puts(d[i].ime);
            cout<<endl<<"Ima "<<d[i].st<<" prebivalcev";
            cout<<endl<<"Glavno mesto je: ";
            puts(d[i].glav);
        }
    }
}