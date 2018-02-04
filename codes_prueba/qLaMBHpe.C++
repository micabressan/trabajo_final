#include <bits/stdc++.h>
#include <assert.h>
#include <unordered_map>
using namespace std;
 
typedef long long ll;
typedef long double ld;
typedef vector < long long > vll;
typedef pair < long long, long long > pll;
typedef pair < int, int > pii;
typedef vector < int > vii;
 
#define csl ios_base::sync_with_stdio(false); cin.tie(NULL)
#define l(x) (((x) << 1) | 1)
#define r(x) ((l(x)) + 1)
#define mp make_pair
#define fst first
#define snd second
 
ll t, n, u, v, m, q, r, ql, qr, k, l, s, x, y, w, a, b;
const int N = 1e6 + 5;
const long long mod = 1e9 + 7;
const long long INF = 1LL << 57LL;
const bool JUDGE = false;
int X[60000], Y[60000];
pii S[N], W[N], _S[N], _W[N];
bool valid[N];
priority_queue < pii > wq, sq;
bool p(ll tim) {
	int x = 0;
	int i = 0;
	wq = priority_queue < pii > ();
	sq = priority_queue < pii > ();
	for (int i = 0; i < n; ++i) valid[i] = true;
	while (i < a) {
		while (x < n && W[x].fst < X[i]) {
			if (valid[W[x].snd]) {
				valid[W[x].snd] = false;
				wq.push(_S[W[x].snd]);
			}
			x++;
		}
		int j = 0;
		while (wq.size() > 0 && j < tim) {
			pii y = wq.top();
			wq.pop();
			j++;
		}
		i++;
	}
	while (wq.size() > 0) {
		pii y = wq.top();
		wq.pop();
		valid[y.snd] = true;
	}
	i = 0;
	x = 0;
	while (i < b) {
		while (x < n && S[x].fst < Y[i]) {
			if (valid[S[x].snd]) {
				sq.push(_W[S[x].snd]);
				valid[S[x].snd] = false;
			}
			x++;
		}
		int j = 0;
		while (sq.size() > 0 && (j < tim)) {
			pii y = sq.top();
			sq.pop();
			valid[y.snd] = false;
			j++;
		}
		i++;
	}
	while (sq.size() > 0) {
		pii y = sq.top();
		sq.pop();
		valid[y.snd] = true;
	}
	for (int i = 0; i < n; ++i) if (valid[i]) {
		//cout << i << "h\n";
		return false;
	}
	return true;
}
int main(){
	csl;
	if (JUDGE) {
        freopen("in.txt", "r", stdin);
        freopen("out.txt", "w", stdout);
	}
	cin >> a >> b >> n;
	for (int i = 0; i < a; ++i) {
		cin >> X[i];
	}
	for (int i = 0; i < b; ++i) {
		cin >> Y[i];
	}
	for (int i = 0; i < n; ++i) {
		cin >> W[i].fst >> S[i].fst;
		W[i].snd = S[i].snd = i;
		_S[i] = S[i];
		_W[i] = W[i];
	}
	ll lo = 1, hi = a + b + n; 
	sort(W, W + n), sort(S, S + n);
	sort(X, X + a), sort(Y, Y + b);
	while (lo < hi) {
		int mid = lo + (hi - lo) / 2;
		if (p(mid)) hi = mid;
		else lo = mid + 1;
	}
	if (p(lo))	cout << lo << '\n';
	else cout << -1 << '\n';
	return 0;
}