#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

int main() {
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    string s;
    getline(cin, s);
    int sum = 0, sz = s.size(), i = 0;
    while (i < sz) {
        char c = s[i];
        if (!(c & 0x80)) {
            ++i;
        } else if ((c & 0xf0) == 0xf0) {
            i += 4;
        } else if ((c & 0xe0) == 0xe0) {
            i += 3;
        } else if ((c & 0xc0) == 0xc0) {
            i += 2;
        }
        sum++;
    }
    cout << sum << endl;
    return 0;
}