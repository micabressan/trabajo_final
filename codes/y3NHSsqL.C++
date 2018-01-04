#include <iostream>
using namespace std;
double fx(double x)
{
    return (x*x*x*x/500-x*x/200-3/250);
}
double gx(double x)
{
    return (-x*x*x/30+x/20+1/6);
}

int main()
{
    double a,b,c,x,p1,p2;
    a=2;
    b=10;
    c=1000;
    x=(b-a)/c;

    for(int i=0; i<c; i++)
    {
        p1+=(x*f(a+i*x));
        p2+=(x*g(a+i*x));
    }
    cout<<(b-a)*(19+61/125+32+2/3)-(p1+p2*-1);
}