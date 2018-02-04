#include <iostream>
#include <string>

using namespace std;

int main() {
    string s;
    getline(cin, s);
    int sz = s.size(), i = 0;
    while (getline(cin, s)) {
        while (i < sz) {
            unsigned char ch = s[i];
            int code = ch;
            if (!(code & 0x80)) {
                ++i;
            } else if ((code & 0xf0) == 0xf0) {
                code ^= 0xf0;
                for (int j = 1; j <= 3; ++j) {
                    ch = s[i + j] ^ 0x80;
                    code = (code << 6) | ch;
                }
                i += 4;
            } else if ((code & 0xe0) == 0xe0) {
                code ^= 0xe0;
                for (int j = 1; j <= 2; ++j) {
                    ch = s[i + j] ^ 0x80;
                    code = (code << 6) | ch;
                }
                i += 3;
            } else if ((code & 0xc0) == 0xc0) {
                code ^= 0xc0;
                ch = s[i + 1] ^ 0x80;
                code = (code << 6) | ch;
                i += 2;
            }
            cout << code << " ";
        }
    }
    cout << endl;
    return 0;
}