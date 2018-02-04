#include <iostream>
#include <vector>
#include <deque>
using namespace std;

int main() {
    int n, m, maxDif;
    cin >> n;
    vector <int> temp(n);
    for (int i = 0; i != n; ++i)
        cin >> temp[i];
    cin >> m;
    for (int i = 0; i != m; ++i) {
        cin >> maxDif;
        deque <pair <int, int> > mind;
        deque <pair <int, int> > maxd;
        int maxsize = 1, a = 1, b = 1;
        for (int j  = 0; j < n; ++j) {
            int cur = temp[j];
            while (!maxd.empty() && cur >= maxd.back().first) {
                maxd.pop_back();
            }
            maxd.push_back(make_pair(cur, j));
            while (!mind.empty() && cur <= mind.back().first) {
                mind.pop_back();
            }
            mind.push_back(make_pair(cur, j));
            if (abs(maxd.front().first - mind.front().first) > maxDif) {
                if (cur == maxd.front().first) {
                    while (abs(mind.front().first - cur) > maxDif)
                        mind.pop_front();
                } else {
                    while (abs(maxd.front().first - cur) > maxDif)
                        maxd.pop_front();
                }
            }
            if (abs(maxd.front().second - mind.front().second) + 1 > maxsize) {
                a = min(maxd.front().second, mind.front().second) + 1;
                b = max(maxd.front().second, mind.front().second) + 1;
                maxsize = abs(maxd.front().second - mind.front().second) + 1;
            }
        }
        cout << a << ' ' << b << '\n';
    }
    return 0;
}