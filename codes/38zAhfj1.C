#include "stdafx.h"
#include "math.h"

double function(double x);
void equation(double a, double b, double delta);

int main()
{
	double a = 0, b = 5, delta = 0.0001;
	equation(a, b, delta);
	getchar();
    return 0;
}


double function(double x) {
	return 2 - exp(x) + 2 * pow(x, 2);
}

void equation(double a, double b, double delta) {
	do {
		double x_current = (a+b)/ 2.;
		double y_current = function(x_current);
		if (fabs(y_current) < delta) {
			printf("Equation root: %f\n", x_current);
			return;
		}
		if (function(a)*y_current < 0) {
			b = x_current;
		}
		else {
			a = x_current;
		}
		printf("Current x: %f, current y: %f\n", x_current, y_current);
	} while (true);
}