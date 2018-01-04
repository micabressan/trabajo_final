#include <iostream>
#include <string>

using namespace std;

int main() {
    unsigned int x;
    while (cin >> x) {
        unsigned int res = 0;
        if ((x & (1u << 7)) != 0) {
            if ((x & (1u << 6)) != 0) {
                if ((x & (1u << 5)) != 0) {
                    if ((x & (1u << 4)) != 0) {
                        res = x % (1u << 3);
                        res <<= 6;
                        cin >> x;
                        res += x % (1u << 6);
                        res <<= 6;
                        cin >> x;
                        res += x % (1u << 6);
                        res <<= 6;
                        cin >> x;
                        res += x % (1u << 6);
                    } else {
                        res = x % (1u << 4);
                        res <<= 6;
                        cin >> x;
                        res += x % (1u << 6);
                        res <<= 6;
                        cin >> x;
                        res += x % (1u << 6);
                    }
                } else {
                    res = x % (1u << 5);
                    res <<= 6;
                    cin >> x;
                    res += x % (1u << 6);
                }
            }
        } else {
            res = x % (1u << 7);
        }
        cout << (char) res;
    }
    cout << endl;
}