#include <D:\VC2005\Eigen\LU>// provides LU decomposition
#include <D:\VC2005\Eigen\Array>// provides random matrices

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <D:\VC2005\Eigen\Dense>
#include <D:\VC2005\Eigen\Sparse>
#include <ctime> 
using namespace std; 
using namespace Eigen; 
using Eigen::MatrixXd;
typedef Eigen::SparseMatrix<double> SpMat; // declares a column-major sparse matrix type of double
typedef Eigen::Triplet<double> T;

// * * * * * * * * * * * * * * * * * * * * * * * * * * *
int main()
// * * * * * * * * * * * * * * * * * * * * * * * * * * *
{
//-----------------------------------------------------------
// We will considr a linear system with 4 variables and 4 equations
//-----------------------------------------------------------
   int n = 4; // size of the image
   std::vector<T> coefficients; // list of non-zeros coefficients
   Eigen::VectorXd b(n); // the rbight hand side-vector 
//-----------------------------------------------------------
// Create dense Matrix A
//-----------------------------------------------------------
   MatrixXd MtxA = MatrixXd::Random(4, 4);
   MtxA << 5,2,4,0, 1,5,0,4, 3,0,5,2, 0,3,1,5;

//------------------------------------------
// Now create/populate an according Sparse Matrix
//------------------------------------------
   for(int j=0; j<n; ++j)
   {
      for(int i=0; i<n; ++i)
      {
           if (MtxA(j,i)*MtxA(j,i)>1e-5) {
         coefficients.push_back(T(j,i,MtxA(j,i)));
         } //if..
      } // ..for i
   } 
   SpMat SparseA(n,n);
   SparseA.setFromTriplets(coefficients.begin(), coefficients.end());
//------------------------------------------
   cout << "Here is the Sparse matrix SparseA:\n"<< SparseA << endl;
   cin.get();   
   
//-----------------------------------------------------------
//   A right hand side vector (RHS Vector)is declared. I chose these values such that
//   the solution will be x1=1 x2=2 x3=3 x4=4
//-----------------------------------------------------------
   b << 21,27,26,29; //this is RHS for solution vector x=1,2,3,4
   //b << 26,28,29,29; //this is RHS for solution vector x=2,2,3,4
   cout << "Here is the Vector b:\n"<< b << endl;
   
//*************************************************************
//   SOLVE: Now we solve the NLS for RHS b using BICGSTAB  method. 
//*************************************************************
   Eigen::BiCGSTAB<SparseMatrix<double> >  BCGST;
   BCGST.compute(SparseA);
   Eigen::VectorXd X;
   X = BCGST.solve(b);
   cout << "Here is the Vector x using BICGSTAB :\n"<< X << endl;
   cin.get();
}