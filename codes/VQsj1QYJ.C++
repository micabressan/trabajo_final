#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <sstream>
#include <iomanip>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <cctype>
#include <cstring>
#include <vector>
#include <list>
#include <queue>
#include <deque>
#include <stack>
#include <map>
#include <set>
#include <algorithm>
#include <iterator>
#include <bitset>
#include <ctime>
#include<complex>
using namespace std;

#define FOR(i,a,b) for (int i = (a); i < (b); i++)
#define RFOR(i,b,a) for (int i = (b)-1; i >= (a); i--)
#define ITER(it,a) for (__typeof(a.begin()) it = a.begin(); it != a.end(); it++)
#define FILL(a,value) memset(a, value, sizeof(a))

#define SZ(a) (int)a.size()
#define ALL(a) a.begin(), a.end()
#define PB push_back
#define MP make_pair

typedef long long LL;
typedef vector<int> VI;
typedef pair<int, int> PII;
typedef pair<long long, long long> PLL;


const double PI = acos(-1.0);
const int INF = 1000 * 1000 * 1000 + 7;
const LL LINF = INF * (LL)INF;

const int MAX = 1000 * 1000 + 47;

int A[MAX];
int B[MAX];
int C[MAX];
vector<int> V[MAX];
vector<int> dp[MAX];
int P[MAX];
int S[MAX];
int D[MAX];

//#define DEBUG
int main()
{
	//freopen("in.txt", "r", stdin);
	//freopen("out.txt", "w", stdout);
	ios::sync_with_stdio(false); cin.tie(0);
	int n;
	cin >> n;
	FOR(i, 0, n)
	{
		cin >> A[i];
		B[i] = A[i];
	}

	sort(B, B + n);
	int bsz = unique(B, B + n) - B;
	int csz = 0;
	FOR(i, 0, n)
	{
		if (i && A[i] == A[i - 1]) continue;
		C[csz++] = lower_bound(B, B + bsz, A[i]) - B;
	}

	FOR(i, 0, csz)
	{
		V[C[i]].push_back(i);
	}

#ifdef DEBUG
	cout <<endl << "C=" << endl;
	FOR(i, 0, csz)
	{
		cout << C[i] << " ";
	}
	cout << endl;

	cout << endl << "V=" << endl;
	FOR(i, 0, bsz)
	{
		cout << i << ": ";
		FOR(j, 0, SZ(V[i])) cout << V[i][j] << " ";
		cout << endl;
	}
#endif

	FOR(i, 0, bsz)
	{
		dp[i].assign(SZ(V[i]), -INF);
	}

	dp[0].assign(SZ(V[0]), 0);
	FOR(i, 0, bsz - 1)
	{
		FOR(j, 0, SZ(V[i]))
		{
			D[j] = -INF;
			S[j] = -INF;
			P[j] = -INF;
		}

		FOR(j, 0, SZ(dp[i]))
		{
			if (j)
			{
				P[j - 1] = max(P[j - 1], dp[i][j]);
			}

			if (j + 1 != SZ(dp[i]))
			{
				S[j + 1] = max(S[j + 1], dp[i][j]);
			}
		}

		int cur = -INF;
		FOR(j, 0, SZ(dp[i]))
		{
			cur = max(cur, S[j]);
			D[j] = max(D[j], cur);
		}

		cur = -INF;
		RFOR(j, SZ(dp[i]), 0)
		{
			cur = max(cur, P[j]);
			D[j] = max(D[j], cur);
		}

		if (SZ(dp[i]) == 1)
		{
			D[0] = dp[i][0];
		}

		int maxx = -INF;
#ifdef DEBUG
		cout << i << ":";
		FOR(j, 0, SZ(dp[i])) cout << D[j] << " ";
		cout << endl;
#endif
		FOR(j, 0, SZ(dp[i]))
		{
			maxx = max(maxx, D[j]);
		}

		FOR(j, 0, SZ(dp[i + 1]))
		{
			dp[i + 1][j] = maxx;
		}

		FOR(j, 0, SZ(V[i]))
		{
			int pos = V[i][j];
			if (pos + 1 != csz && C[pos] + 1 == C[pos + 1])
			{
				int ind = lower_bound(ALL(V[i + 1]), pos + 1) - V[i + 1].begin();
				dp[i + 1][ind] = max(dp[i + 1][ind], D[j] + 1);
			}
		}
	}

	int maxx = -INF;
	FOR(i, 0, SZ(dp[bsz - 1])) maxx = max(maxx, dp[bsz - 1][i]);

#ifdef DEBUG
	cout << endl << "dp=" << endl;
	FOR(i, 0, bsz)
	{
		cout << i << ": ";
		FOR(j, 0, SZ(dp[i])) cout << dp[i][j] << " ";
		cout << endl;
	}
	cout << "max=" << maxx << endl;
#endif
	cout << csz - 1 - maxx << endl;
}