#include <bits/stdc++.h>

using namespace std;


int main() {
    int n;
    cin >> n;
    vector<vector<int> > subs;

    for (int i = 0; i < (1 << n); ++i) {
        subs.push_back(vector<int>());
        for (int j = 0; j < n; j++) {
            if ((i & (1 << j))!= 0)
                subs.back().push_back(j);
        }
    }
    sort(subs.begin(), subs.end());
    for (auto sub : subs) {
        for (auto x : sub)
            cout << x + 1 << " ";
        cout << "\n";
    }
    return 0;
}