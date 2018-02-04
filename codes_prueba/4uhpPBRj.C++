#include <bits/stdc++.h>
#define bigdata ios::sync_with_stdio(false);cin.tie(nullptr);
using namespace std;
typedef long long ll;

const int INF = 1E9 + 7;
int n, m;
string a, b;
vector<vector<int>> dp;
vector<vector<int>> par;
void debug(const vector<vector<int>> &a){
    for (int i = 0; i < a.size(); ++i){
        for (int j = 0; j < a[i].size(); ++j){
            cout << a[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;
}
int main(){
    bigdata;
    cin >> a >> b;
    n = a.size();
    m = b.size();
    dp.resize(n + 1, vector<int>(m + 1));
    par.resize(n + 1, vector<int>(m + 1, -1));
    for (int i = 1; i < n + 1; ++i){
        for (int j = 1; j < m + 1; ++j){
            if (a[i - 1] == b[j - 1]){
                if (j == 1){
                    dp[i][j] = dp[i - 1][j] + 1;
                    par[i][j] = 1;
                }
                else{
                    if (dp[i - 1][j] + 1 < dp[i - 1][j - 1]){
                        dp[i][j] = dp[i - 1][j] + 1;
                        par[i][j] = 1;
                    }
                    else{
                        dp[i][j] = dp[i - 1][j - 1];
                        par[i][j] = 2;
                    }
                }
            }
            else{
                dp[i][j] = dp[i - 1][j];
                par[i][j] = 3;
            }
        }
    }
    string ans;
    int curi = n;
    int curj = m;
    while (par[curi][curj] != -1){
        if (par[curi][curj] == 1){
            --curi;
        }
        else if(par[curi][curj] == 2){
            ans += a[curi - 1];
            --curi;
            --curj;
        }
        else if(par[curi][curj] == 3){
            ans += a[curi - 1];
            --curi;
        }
    }
    for (int i = ans.size() - 1; i > -1; --i){
        cout << ans[i];
    }
}