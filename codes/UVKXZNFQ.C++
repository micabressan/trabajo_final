#include <bitset>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main() {
    int n;
    cin >> n;
    string str;
    vector<string> strs;
    strs.reserve(n);
    for (int i = 0; i != n; i++) {
        cin >> str;
        strs.push_back(str);
    }
    for (auto i = 0; i != (1 << strs.size()); ++i) {
        bitset<32> bits(i);
        string res;
        for (auto j = 0; j != strs.size(); j++) {
            if (bits[j]) {
                res += strs[j] + ",";
            }
        }
        if (!res.empty()) {
            res.pop_back();
        }
        cout << "[" << res << "]" << endl;
    }
}