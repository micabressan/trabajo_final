
#include <iostream>

using namespace std;

void fill(int **mat)
{
    mat[0][0]=1;
    mat[1][1]=1;
    mat[0][1]=0;
    mat[1][0]=0;
}

int main(int argc,char* argv[])
{

    int mat[2][2];
    
    fill(mat);
    
    cout<<mat[0][0]<<endl;

    return 0;
}