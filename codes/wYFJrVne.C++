#include <iostream>
#include <vector>
#include <cmath>

typedef std::vector<std::vector<double> > matrix;

const double a = 0;
const double b = 1;
const double lambda = 1;


double X(int idx, double h) {
  return a + idx * h;
}

double K(double xi, double xj) {
	return xi * xj * xj;
  //return 1 / (1 + std::pow((xi - xj), 4));
}

std::vector<double> Cholesky(matrix A, std::vector<double> B) {
  int n = B.size();
	std::vector<double> X(n);

  double *Y, S;
  int i, j, k;

  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      if (i == j) {
        S = 0.0;
				for (k = 0; k < i; k++)
					S += A[i][k] * A[i][k];
				A[i][i] = sqrt(A[i][i] - S);
			} else if (i > j) {
				S = 0.0;
				for (k = 0; k < j; k++)
					S += A[i][k] * A[j][k];
				A[i][j] = (A[i][j] - S) / A[j][j];
			}
	}


	// обратный ход
	Y = new double[n];
	for (i = 0; i < n; i++)
	{
		S = 0.0;
		for (j = 0; j < i; j++)
			S += A[i][j] * Y[j];
		Y[i] = (B[i] - S) / A[i][i];
	}

  for (i = n - 1; i >= 0; i--) {
    S = 0.0;
    for (j = n - 1; j > i; j--)
    	S += A[j][i] * X[j];
    X[i] = (Y[i] - S) / A[i][i];
  }

	delete Y;

	return X;
}

matrix linear_system(int N, auto f){
  matrix m(N, std::vector<double>(N+1));

  double h = (b - a) / N;
  for (int i = 0; i < N; i++)
    m[i][N] = f(X(i, h));

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      m[i][j] = -h/3 * lambda * K(X(i, h), X(j, h));
			if (j != 0 && j != N-1 && j % 2 == 0)
        m[i][j] *= 2;
      if (j != 0 && j != N-1 && j % 2 != 0)
        m[i][j] *= 4;
      if (i == j)
        m[i][i]++;
    }
  }
	return m;
}


auto Newton(int n, double x_arr[], double y_arr[]) {
  return [n, x_arr, y_arr](double x) {
    double sum = y_arr[0];
    for (int i = 1; i < n; ++i) {
			double F = 0;
			for (int j = 0; j <= i; ++j) {
				double den = 1;
				for (int k = 0; k <= i; ++k)
					if (k != j)
						den *= (x_arr[j] - x_arr[k]);
				F += y_arr[j] / den;
			}

			for (int k = 0; k < i; ++k)
				F *= (x - x_arr[k]);
			sum += F;
		}
		return sum;
	};
}


int main()
{
  double x_arr[] = { 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 };
  //double y_arr[] = { 1.5, 1.495, 1.48, 1.455, 1.42, 1.375, 1.32, 1.255, 1.18, 1.095, 1 };
	double y_arr[] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

	int N = 1000;

	auto f = Newton(10, x_arr, y_arr);

  matrix ls = linear_system(N, f);
  matrix A(N, std::vector<double>(N));
  std::vector<double> b(N);

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++)
      A[i][j] = ls[i][j];
    b[i] = ls[i][N];
  }

  std::vector<double> x = Cholesky(A, b);

	for (int i = 0; i < N; i++)
		std::cout << x[i] << " ";
	std::cout << std::endl;
	return 0;
}