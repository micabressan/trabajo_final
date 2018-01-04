#include <bits/stdc++.h>
using namespace std;

int n, m;
int k[100005];
int o[100005];


bool check(int K) {
    priority_queue <int> q;
    
    for(int i = 0; i < n; i++)
        q.push(k[i]);
    
    for(int i = K - 1; i >= 0; i--) {
        int a = q.top();
        q.pop();
        if(a < o[i]) return false;
        q.push(a - o[i]);
    }
    return true;
}


int main() {
    scanf("%d %d", &n, &m);
    
    for(int i = 0; i < n; i++)
        scanf("%d", &k[i]);
    
    for(int i = 0; i < m; i++)
        scanf("%d", &o[i]);
    sort(o, o + m);
    
    int lo = 0;
    int hi = m;
    
    while(lo < hi) {
        int mi = (lo + hi + 1) / 2;
        if(check(mi)) lo = mi;
        else hi = mi - 1;
    }
    printf("%d\n", (lo + hi + 1) / 2);
}