#include <iostream>
#include <string>

using namespace std;

int main() {
    string s;
    getline(cin, s);

    int count = 0;
    unsigned int code = 0;
    int bites = 0;
    for (auto it = s.begin(); it != s.end(); ++it) {
        unsigned int i = *it;

        if (i >> 4 == 15) {
            i >>= 4;
            code = i << 18;
            bites = 12;

        } else if (i >> 5 == 7) {
            i >>= 3;
            code = i << 12;
            bites = 6;

        } else if (i >> 6 == 3) {
            i >>= 2;
            code = i << 6;
            bites = 0;

        } else if (i >> 7 == 0) {
            code = i;
            cout << code << ' ';
            code = 0;
            bites = 0;

        } else {
            i >>= 2;
            if (bites == 0) {
                code += i;
                cout << code << ' ';
                code = 0;

            } else {
                code += i << bites;
                bites -= 6;
            }
        }
    }

    cout << endl;
}