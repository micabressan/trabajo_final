#include <math.h>
#include <stdio.h>

double Epsylone() { 
	double eps = 1.0;
	while ((double)(eps / 2 + 1) > 1) {
		eps = eps / 2;
	}
	return eps;
}

int F(int n)
{
	int r = 1;
	for (int i = 2; i <= n; ++i)
		r *= i;
	return r;
}

int main() {
	int k;
	printf("Please, inter the number of parts of the segment: ");
	scanf_s("%d", &k);
	double x, d, S, eps;
	eps = Epsylone();
	double a = 0.1;
	double b = 0.6;
	double h = (b - a) / (double)k;
	int n;
	printf("\n Machine eps= %.17f \n", eps);
	printf("--------------------------------------------------------------\n");
	printf("|   x   |           S         |(1-(x)^2/2)cosx-(x/2)sinx|  n |\n");
	printf("|-------|---------------------|-------------------------|----|\n");
	for (x = a; x - b + h < eps; x += h) {
		n = 0;
		double baseMember = pow (x, 2*n);
		double mediumMember = baseMember;
		S = d = baseMember;
		while (fabs(d) > eps) {
			n++;
			mediumMember *= baseMember;
			double factor = pow(-1, n)*((2 * pow(n, 2) + 1) / F(2 * n))*pow(x, 2 * n);
			if (fabs(factor) == INFINITY) break;
			d = factor*mediumMember;
			S += d;
		}
		printf("| %.3f | %2.17f |   %2.17f   | %2d |\n", x, S, (1 - (pow(x, 2) / 2))*cos(x) - (x / 2)*sin(x), n);
	}
	printf("--------------------------------------------------------------\n");
	return 0;
}