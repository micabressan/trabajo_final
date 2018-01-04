void multiplicar_restar_matrices(double *a,int fa,int ca,int lda,double *b,int fb,int cb,int ldb,double *c,int fc,int cc,int ldc)
{
  double alpha = -1.0; 
  double beta = 1.0;
  fprintf(stderr, "0.-->\n");
  double *copiaA = (double *)mkl_malloc( fa*ca*sizeof( double ), 64 );
  double *copiaB = (double *)mkl_malloc( fb*cb*sizeof( double ), 64 );
  if ( copiaA == NULL || copiaB == NULL) {
    printf( "\n ERROR: Can't allocate memory for matrices. Aborting... \n\n");
    mkl_free(copiaA);
    mkl_free(copiaB);
    exit -1;
  }
  copiar_matriz(a,fa,ca,lda,copiaA,fa,ca,lda);
  copiar_matriz(b,fb,cb,ldb,copiaB,fb,cb,ldb);
  
  #pragma omp parallel
  { 
    int t = omp_get_thread_num();
    int numt = omp_get_num_threads();
    
    double * da = &copiaA[ t * lda * fa / numt ];
    double * dc = &c[ t * ldc * fc / numt ];
    int dfa = (t != numt-1) ? fa / numt : fa / numt + fa%numt;
    
    fprintf(stderr, "1.--> t = %d - numt = %d - dfa = %d\n", t, numt, dfa);
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dfa, cb, ca, alpha, da, lda, copiaB, ldb, beta, dc, ldc);
    
    fprintf(stderr, "2.--> t = %d\n", t);
  }
  
  mkl_free(copiaA);
  mkl_free(copiaB);
}