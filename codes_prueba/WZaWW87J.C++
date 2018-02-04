#include <bits/stdc++.h>
#define bigdata ios::sync_with_stdio(false);cin.tie(nullptr);
using namespace std;
typedef long long ll;

const int INF = 1E9 + 7;
const long long p = 41, Mod = 2000000011;
vector<int> st;
vector<int> h;
vector<int> ans;
int n, k;

int subhash(vector<int> &h, int l, int r){
    long long right = h[r];
    long long left = 0;
    if (l != 0)
    {
        left = h[l - 1];
    }
    left = (left * st[r - l + 1]) % Mod;
    return (right - left + Mod) % Mod;
}
void gethash(const string &s, vector<int> &h){
    h.push_back(s[0]);
    for (int i = 1; i < s.size(); ++i)
    {
        h.push_back((h[i - 1] * p + s[i]) % Mod);
    }
}
void prepare_st(int len){
    st.push_back(1);
    for (int j = 1; j < len; ++j){
        st.push_back((st[j - 1] * p) % Mod);
    }
}
bool check(int best, int cur, int m){
    return subhash(h, best, best + m) != subhash(h, cur, cur + m);
}
void add(int sum){
    int pos = 0;
    while (sum != 0){
        int tmp = sum % 10;
        sum /= 10;
        int curpos = pos;
        int curadd = tmp;
        while (ans[ans.size() - 1 - curpos] + curadd > 9){
            ans[ans.size() - 1 - curpos] = (ans[ans.size() - 1 - curpos] + curadd) % 10;
            curadd = 1;
            ++curpos;
        }
        ans[ans.size() - 1 - curpos] += curadd;
        ++pos;
    }
}
int main(){
    string s;
    cin >> n >> k >> s;
    h.resize(n);
    ans.resize(n - k + 2);
    prepare_st(n);
    gethash(s, h);
    int best = 0;
    int lens = n - k;
    for (int i = 1; i + lens < n; ++i){
        if (s[best] > s[i]){
            continue;
        }
        if (s[best] < s[i]){
            best = i;
            continue;
        }
        int l = 0;
        int r = n - k + 1;
        while (r - l != 1){
            int m = (l + r) / 2;
            if (check(best, i, m)){
                l = m;
            }
            else{
                r = m;
            }
        }
        l = l + 1;
        if (s[l + i] > s[l + best]){
            best = i;
        }
    }
    int sum = 0;
    for (int i = 0; i < best; ++i){
        sum += s[i] - '0';
    }
    for (int i = best + n - k + 1; i < n; ++i){
        sum += s[i] - '0';
    }
    for (int i = best; i < best + n - k + 1; ++i){
        ans[i - best + 1] = s[i] - '0';
    }
    add(sum);
    int start = 0;
    if (ans[0] == 0){
        start = 1;
    }
    for (int i = start; i < ans.size(); ++i){
        cout << ans[i];
    }
}