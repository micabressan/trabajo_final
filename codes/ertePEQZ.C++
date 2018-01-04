#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

int main() {
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    string s;
    unsigned long long code = 0;
    while (cin >> code) {
        if (code < (1 << 8)) {
            cout << char(code);
        } else if (code < (1 << 11)) {
            cout << char((code >> 6) | (0xc0));
            cout << char((code ^ ((code >> 6 << 6))) | (0x80));
        } else if (code < (1 << 16)) {
            cout << char((code >> 12) | (0xe0));
            cout << char(((code ^ (((code >> 12) << 12))) >> 6) | (0x80));
            cout << char((code ^ (((code >> 6) << 6))) | (0x80));
        } else {
            cout << char((code >> 18) | (0xf0));
            cout << char(((code ^ (((code >> 18) << 18))) >> 12) | (0x80));
            cout << char(((code ^ (((code >> 12) << 12))) >> 6) | (0x80));
            cout << char((code ^ (((code >> 6) << 6))) | (0x80));
        }
    }
    return 0;
}