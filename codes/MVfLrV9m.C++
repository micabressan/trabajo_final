#include <iostream>
#include <vector>
#include <string>
using namespace std;

int N;
const int MAXN = 100000;
vector<pair<int, int> > v(MAXN);

int main () {
    cin >> N;

    int begin = 0;
    int end = 0;
    for (int i = 0; i < N;++i) {
        string command;
        cin >> command;
        if (!command.compare("IZBACI")) {
            --v[begin].second;
            if (v[begin].second == 0) {
                ++begin;
            }
        }

        if (!command.compare("NAJMANJI")) {
            cout << v[begin].first << endl;
        }

        if (!command.compare("DODAJ")) {
            int element;
            cin >> element;
            if (begin == end) {
                v[end] = make_pair(element, 1);
                ++end;
            } else {
                int occurance_number = 1;
                while (begin <= end - 1 && element <= v[end - 1].first) {
                    occurance_number += v[end - 1].second;
                    --end;
                }
                v[end] = make_pair(element, occurance_number);
                ++end;
            }
        }
    }

    return 0;
}