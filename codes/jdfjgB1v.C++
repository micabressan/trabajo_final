#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    string utf;
    getline(cin, utf);
    int counter = 0;
    for (int i = 0; i != utf.size(); ++i) {
        unsigned int k = 7;
        bool result = utf[i] & (1 << k);
        if (result) {
            result = utf[i] & (1 << (k - 1));
            if (result) {
                result = utf[i] & (1 << (k - 2));
                if (result) {
                    result = utf[i] & (1 << (k - 3));
                    if (result) {
                        i += 3;
                        counter += 1;
                    } else {
                        i += 2;
                        counter += 1;
                    }
                } else {
                    i += 1;
                    counter += 1;
                }
            }
        } else {
            ++counter;
        }
    }
    cout << counter << "\n";
}