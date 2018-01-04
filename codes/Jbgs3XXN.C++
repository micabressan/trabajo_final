#include <iostream>
using namespace std;

int main() {
    unsigned long long number, count = 0;
    cin >> number;
    for (; number; count++)
        number &= (number - 1);
    cout << count << "\n";
}