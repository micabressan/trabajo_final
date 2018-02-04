#pragma comment(linker, "/stack:32000000")
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <iomanip>
#include <queue>
#include <set>
#include <map>
#include <math.h>
#include <functional> 
#include <stack>
#include <cstring>
#include <locale> 
#include <cstdio>


using namespace std;

#define ll long long
#define ull unsigned ll
#define mp(a,b) (make_pair(a,b))
#define X first
#define Y second        
#define INF (int)1e9
#define PR (ll)10000000-3
#define OST 1000000007
#define pii pair<int,int> 
#define pll pair<ll,ll>
#define pdd pair<double, double>
#define EPS (double)1e-7
#define PI (double)3.1415926535897
#define vi vector<int>
#define vii vector< vi >
#define vl vector<ll>
#define vc vector<char>

int n, m, t, k;
vi v;
const int maxn = 700000;
pll tree[4 * maxn];

void update(int ver, int l, int r, int vecl, int vecr, ll val) {
 if (vecl == l && vecr == r)
	{
		tree[ver].first += val;
		tree[ver].second += val;
	}
	else {
		int mid = (l + r) / 2;
				
		if (vecr < mid)
			update(ver * 2, l, mid, vecl, vecr, val);
		else if (vecl >= mid)
			update(ver * 2 + 1, mid, r, vecl, vecr, val);
		else {
			update(ver * 2, l, mid, vecl, mid, val);
			update(ver * 2 + 1, mid, r, mid, vecr, val);
		}
		tree[ver].second = min(tree[2 * ver].second, tree[2 * ver + 1].second) + tree[ver].first;
	}
}


int __time[32][13][25][61];

int main() {
#ifdef _DEBUG
	//freopen("input.txt", "r", stdin); freopen("output.txt", "w", stdout);
#else
	//string _file_name_ = "sum";
	//freopen((_file_name_ + ".in").c_str(), "r", stdin); freopen((_file_name_ + ".out").c_str(), "w", stdout);
#endif
	ios::sync_with_stdio(false);
	int m;
	
	int n;
	cin >> n;
	
	int last = 0;
	for (int M = 0; M <= 12; M++)
		for (int d = 0; d <= 31; d++) 
			for (int h = 0; h <= 24; h++) 
				for (int m = 0; m <= 60; m++) 
					__time[d][M][h][m] = last++;


	int c;
	for (int i = 0; i < n; i++) {
		int d, M, h, m;
		scanf("%d %d.%d %d:%d", &c, &d, &M, &h, &m);
		//cout << c << " "<<d<<"."<<M<<" "<<h<<":"<<m << endl;
		int index = __time[d][M][h][m];
		update(1, 0, maxn, index, maxn, c);
		ll ans = tree[1].second;
		cout << min(ans, (ll)0) << endl;
	}
	return 0;
}