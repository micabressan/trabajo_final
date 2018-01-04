#include <iostream>
#include <math.h>

using namespace std;

int func(int *x, int a, int b)
{
    if(b >= a){
        if(x[b] <= b*b)
            return 1;
        else return func(x, a, b - 1);
    } else return 0;
}

int main() {
    
    int n = 0, b1, a1 = 0, a2, b2;
    cout << "Введите размер массива: ";
    cin >> n;
    
    int *arr = new int [n];
    
    for(int i = 0; i < n; i++){
        cout << "a[" << i << "] = ";
        cin >> arr[i];
    }
    
    
    b1 = (n % 2 == 0) ? (n - 1)/2 : (n - 2) / 2;
    a2 = (n % 2 == 0) ? (n - 1)/2 : (n - 2) / 2;
    b2 = (n - 1);
    
    
    if(func(arr, a1, b1) == 1 || func(arr, a2, b2) == 1)
        cout << "Да существует" << endl;
    else cout << "Нет ни одного" << endl;
    
    return 0;
}