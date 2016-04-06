#include <iostream>
using namespace std;
 
int main(){
    long N, res = 1;
    cin >> N;
    for (long i = 2; i <= N; ++i){
        res *= i;
        while (res > 0 && res % 10 == 0)
            res /= 10;
        res = res % 10;
    }
    cout << res;
    return 0;
}