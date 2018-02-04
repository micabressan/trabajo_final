#include <iostream>
#include <math.h>

using namespace std;

int InputFunc(int **arr, int size)
{
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            cout << "[" << i << "][" << j << "] = ";
            cin >> arr[i][j];
        }
    }
    return 0;
}

int OutputFunc(int **arr, int size)
{
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            cout << arr[i][j] << "\t";
        }
        cout << "\n\n";
    }
    return 0;
}

int main() {
    
    int n = 0;
    cout << "Введите Размер Матрицы: ";
    cin >> n;
    
    int **a = new int *[n];
    int **b = new int *[n];
    int **c = new int *[n];
    
    for(int i = 0; i < n; i++){
        a[i] = new int [n];
        b[i] = new int [n];
        c[i] = new int [n];
    }
    cout << "\n\n";
    cout << "Введите первую матрицу: " << endl;
    InputFunc(b, n); // Input b array
    
    cout << "\n";
    cout << "Введите вторую матрицу: " << endl;
    InputFunc(c, n); // Input c array
    
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            a[i][j] = abs(b[i][j]) <= abs(c[i][j]) ? c[i][j] : b[i][j];
        }
    }
    cout << "\n\n";
    cout << "Полученная матрица" << endl;
    OutputFunc(a, n); // Output a array
    
    for(int i = 0; i < n ; i++)
    {
        delete [] a[i];
        delete [] b[i];
        delete [] c[i];
    }
    
    delete [] a;
    delete [] b;
    delete [] c;
    
    return 0;
}