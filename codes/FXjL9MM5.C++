#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

bool cmp (pair < pair <int, int>, int > v1, pair < pair <int, int>, int > v2) {
    return v1.second < v2.second;
}

int main() {
    ifstream in;
    in.open("landau.txt");
    int a[10][10];
    int cnt[10];
    int sum = 0;
    for (int i = 0; i < 10; ++i)
        for(int j = 0; j < 10; ++j)
            a[i][j] = 1;
    for(int i = 0; i < 10; ++i) {
        a[i][i] = 0;
        cnt[i] = 0;
    }
    while (1) {
        int x, y;
        in >> x >> y;
        //cout << x << ' ' << y << endl;
        --x;
        --y;
        if (x == 10)
            break;
        a[x][y] = 0;
        a[y][x] = 0;
        ++cnt[x];
        ++cnt[y];
    }
    vector < pair < pair <int, int>, int > > ans;
    for (int i = 0; i < 10; ++i) {
        for (int j = i + 1; j < 10; ++j) {
            if (a[i][j]) {
                if (i == 7 || j == 7)
                    continue;
                ans.push_back(make_pair(make_pair(i, j), cnt[i] + cnt[j]));
                //cout << i + 1 << ' ' << j + 1 << endl;
            }
        }
    }
    sort(ans.begin(), ans.end(), cmp);
    for (int i = 0; i < ans.size(); ++i) {
        int x = (ans[i].first).first;
        int y = (ans[i].first).second;
        int val = ans[i].second;
        cout << x + 1 << ' ' << y + 1 << ' ' << val << endl;
    }
    return 0;
}