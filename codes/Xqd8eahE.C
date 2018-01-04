#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void culc(void)
{
    FILE* in = fopen("input.txt", "r");
    double x1,y1, x2, y2, x3, y3;
    fscanf(in, "%lf%lf%lf%lf%lf%lf", &x1, &y1, &x2, &y2, &x3, &y3);

    double s = ((x1 - x3) * (y2 - y3) - (y1 - y3) * (x2 - x3)) / 2;

    printf("%f\n", abs(s));

    double m1x = (x1 + x2) / 2;
    double m1y = (y1 + y2) / 2;

    double m2x = (x2 + x3) / 2;
    double m2y = (y2 + y3) / 2;

    double m3x = (x1 + x3) / 2;
    double m3y = (y1 + y3) / 2;

    double res1 = /*Sqrt*/(pow(m1x - x3, 2) + pow(m1y - y3, 2));
    double res2 = /*Sqrt*/(pow(m2x - x1, 2) + pow(m2y - y1, 2));
    double res3 = /*Sqrt*/(pow(m3x - x2, 2) + pow(m3y - y2, 2));



    if (res1 > res2 && res1 > res3)
        printf("%f", res1);

    if (res2 > res1 && res2 > res3)
        printf("%f", res2);

    if (res3 > res2 && res3 > res1)
        printf("%f", res3);
}

int main(void)
{
    culc();
    return 0;
}