//Projekt III - Grzybobranie
//g++ -I ~/Biblioteki/Eigen3/ Eigen.cpp -o Eigen

#include <iostream>
#include <fstream>
#include <Eigen/Sparse>
#include <Eigen/LU>
#include <Eigen/Dense>
#include <time.h>
#include <cstdio>
#include <chrono>
#include <vector>
#include <string>
#include <sstream>
#include <cmath>
#include <iomanip>

using Eigen::MatrixXd;
using Eigen::MatrixXf;
using Eigen::Matrix;
using Eigen::Matrix2f;
using Eigen::VectorXf;
using Eigen::VectorXd;
using precision = std::chrono::nanoseconds;
using namespace std;
using namespace Eigen;
typedef Eigen::SparseMatrix<double> SparseMatrixXd;
typedef Eigen::SparseVector<double> SparseVectorXd;
typedef Eigen::SparseLU <SparseMatrixXd, Eigen::COLAMDOrdering<double>> SparseSolverD;

struct MeasureTime {

    std::vector<std::chrono::steady_clock::time_point> times;
    std::chrono::steady_clock::time_point oneLast;

    void p() {
        cout << "Mark "
             << times.size() / 2
             << ": "
             << chrono::duration_cast<precision>(times.back() - oneLast).count()
             << endl;
    }

    void m() {
        oneLast = times.back();
        times.push_back(std::chrono::steady_clock::now());
    }

    void t() {
        m();
        p();
        m();
    }

    MeasureTime() {
        times.push_back(std::chrono::steady_clock::now());
    }
};

void wczytaj(string nazwa, string nazwa1) {
    int sizeA;
    string test;

    fstream plik;
    plik.open(nazwa);

    getline(plik, test);
    sizeA = stoi(test);

    SparseMatrixXd SparseMatrixDD(sizeA, sizeA);
    MatrixXd MatrixDD(sizeA, sizeA);

    double **daneMacierz = new double *[sizeA];

    for (int i = 0; i < sizeA; i++) {
        daneMacierz[i] = new double[sizeA];
    }

    for (int i = 0; i < sizeA; i++) {
        for (int j = 0; j < sizeA; j++) {
            getline(plik, test);
            daneMacierz[i][j] = stod(test);
        }
    }

    plik.close();

    for (int i = 0; i < sizeA; i++) {
        for (int j = 0; j < sizeA; j++) {
            SparseMatrixDD.insert(i, j) = daneMacierz[i][j];
            MatrixDD(i, j) = daneMacierz[i][j];
        }
    }

    plik.open(nazwa1);

    getline(plik, test);
    sizeA = stoi(test);

    SparseVectorXd SparseVectorD(sizeA);
    VectorXd VectorD(sizeA);

    double *daneWektor = new double[sizeA];

    for (int i = 0; i < sizeA; i++) {
        getline(plik, test);
        daneWektor[i] = stod(test);
    }

    plik.close();

    for (int i = 0; i < sizeA; i++) {
        VectorD(i) = daneWektor[i];
        SparseVectorD.insert(i) = daneWektor[i];
    }

    for (int i = 0; i < sizeA; i++) {
        delete[] daneMacierz[i];
    }

    delete[] daneMacierz;

    delete[] daneWektor;


    //cout<<"\nSparse :"<< SparseMatrixDD;

    //cout<<"\nDense :"<< MatrixDD;

    //cout<<"\n\n"<< SparseVectorD;

    //cout<<"\n\n"<< VectorD<<"\n";

   Eigen::BiCGSTAB<SparseMatrix<double> >  BCGST;
   BCGST.compute(SparseMatrixDD);
   Eigen::VectorXd X;

    MeasureTime m;
    m.t();
	X = BCGST.solve(VectorD);
    m.t();
    MatrixXd DY = MatrixDD.partialPivLu().solve(VectorD);
    m.t();
    std::cout << std::setprecision( 16 ) << X << endl;
    std::cout << std::setprecision( 16 ) << DY << endl;

}

int main() {

    wczytaj("../macierz.csv", "../wektor.csv");

    system("pause");
    return (0);
}