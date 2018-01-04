#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define n 100
double szereg(double x)
{
double s, w;
int i;
	s=1;
	w=1;
	for(i=1;i<n;i++)
	{
		w=w/pow(i,x);
		s+=w;
	}
return s;
}

int main()
{
	int lp;
	double a, b, krok, x;
	printf("podaj konce przedzialow i liczbe podprzedzialow\n");
	scanf("%lf %lf %d",&a,&b,&lp);
	krok=(b-a)/lp;
	printf("krok=%6.2lf\n\n\n",krok);
	printf(" ----------------------------\n\n");
	printf(" x szereg(x) sin(x)\n --------------------------\n");
	for (x=a;x<=b;x+=krok)
	printf("%10.2lf %7.4lf %7.4lf\n",x,szereg(x),sin(x));
	printf(" ----------------------------\n\n");
return 0;
}