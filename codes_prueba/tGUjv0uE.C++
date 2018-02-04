#include <bits/stdc++.h>
using namespace std;

int main() {
    vector<int> a;
    int z = 0;
    srand(3);
    while (a.size() < 11) {
        int x = rand() % 6, p;
        if (x) cout << x << '\n';
        else cout << '+' << '\n';
        cin >> p;
        while (p > a.size() || p < 0) {cout << "try again\n"; cin >> p;}
        a.insert(a.begin() + p, x);
        int q = 0, r = 0, l = -1;
        for (int i = 1; i + 1 < a.size(); i++) if (!a[i] && a[i - 1] == a[i + 1]) {
            q = max(q, a[i - 1]);
            r++;
            l = i - 1;
            a.erase(a.begin() + i + 1), a.erase(a.begin() + i - 1);
            i = 0;
        }
        if (l != -1) a[l] = q + r;
        for (int i : a) {
            if (i) cout << i << ' ';
            else cout << '+' << ' ';
        }
        cout << '\n';
        z++;
    }
    cout << z << " rounds" << '\n';
}