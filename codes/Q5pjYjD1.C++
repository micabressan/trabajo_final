#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cassert>
#include <ctime>
#include <cmath>
#include <algorithm>
#include <string>
#include <vector>
#include <deque>
#include <queue>
#include <list>
#include <set>
#include <map>
#include <iostream>

#define pb push_back
#define mp make_pair
#define TASKNAME ""

#ifdef LOCAL
#define eprintf(...) fprintf(stderr,__VA_ARGS__)
#else
#define eprintf(...)
#endif

#define TIMESTAMP(x) eprintf("[" #x "] Time = %.3lfs\n",clock()*1.0/CLOCKS_PER_SEC)

#ifdef linux
#define LLD "%lld"
#else
#define LLD "%I64d"
#endif

#define sz(x) ((int)(x).size())

using namespace std;

typedef long double ld;
typedef long long ll;
typedef vector<ll> vll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<bool> vb;
typedef vector<vb> vvb;
typedef pair<int, int> pii;
typedef pair <ll, ll> pll;
typedef pair <ll, int> pli;
typedef vector<pli> vpli;
typedef vector<pii> vpii;

const int inf = 1e9;
const double eps = 1e-9;
const int INF = inf;
const double EPS = eps;

#ifdef LOCAL
struct __timestamper {
  ~__timestamper(){
    TIMESTAMP(end);
  }
} __Timestamper;
#endif

/*Template end*/

bool better(const pll &a, const pll &b) {
  if (a.first != b.first) return a.first < b.first;
  return a.second > b.second;
}

int main()
{
  #ifdef LOCAL
  freopen(TASKNAME".in","r",stdin);
  freopen(TASKNAME".out","w",stdout);
  #endif

  int maxc, m, n;
  while (scanf("%d%d%d", &maxc, &m, &n) == 3) {
    vector<ll> as(m), bs(m);
    for (int i = 0; i < m; i++) {
      scanf(LLD LLD, &as[i], &bs[i]);
      bs[i] -= as[i];
    }

    vector<pll> packs;
    for (int i = 0; i < n; i++) {
      ll cost = 0, profit = 0;
      int k;
      scanf("%d", &k);
      while (k --> 0) {
        int x; ll cnt;
        scanf("%d"LLD, &x, &cnt);
        assert(1 <= x && x <= m);
        x--;
        cost += ll(as[x]) * cnt;
        profit += ll(bs[x]) * cnt;
      }
      if (cost > maxc || profit <= 0) continue;
      packs.pb(mp(cost, profit));
    }
    n = sz(packs);

    vector<pll> states, ne, nstates;
    states.pb(mp(0, 0));

    for (int cid = 0; cid < n; cid++) {
      ll cost = packs[cid].first;
      ll profit = packs[cid].second;

      ne.clear();
      for (int i = 0; i < sz(states); i++) {
        if (states[i].first + cost > maxc) break;
        ne.pb(mp(states[i].first + cost, states[i].second + profit));
      }

      nstates.resize(sz(states) + sz(ne));
      int ptr = 0;
      int p1 = 0, p2 = 0;
      ll maxprof = -1;

      while (p1 < sz(states) || p2 < sz(ne)) {
        if (p1 < sz(states) && (p2 >= sz(ne) || better(states[p1], ne[p2]))) {
          nstates[ptr++] = states[p1++];
        } else {
          nstates[ptr++] = ne[p2++];
        }
        assert(maxprof < nstates[ptr - 1].second);
        maxprof = nstates[ptr - 1].second;
        while (p1 < sz(states) && states[p1].second <= maxprof) p1++;
        while (p2 < sz(ne) && ne[p2].second <= maxprof) p2++;
      }
      nstates.resize(ptr);
      states.swap(nstates);
    }
    printf(LLD"\n", states.back().second);
    break;
  }

  return 0;
}