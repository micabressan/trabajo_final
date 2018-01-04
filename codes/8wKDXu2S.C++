#include <cstdio>
#include <queue>
#include <vector>
#include <climits>
using namespace std;


typedef     long long           LL;
typedef     pair<LL, LL>        ii;


const LL INF = LLONG_MAX;

vector<vector<ii> > adjList;


LL dijkstra(int n, int s, int t)
{
    priority_queue<ii, vector<ii>, greater<ii>> pq;
    LL cost[n+3];
    fill(cost, cost+n+3, INF);

    cost[s] = 0;
    pq.push(ii(0, s));

    while(!pq.empty()) {
        int u = pq.top().second; pq.pop();

        if(u == t) {
            break;
        }

        for(auto &pr : adjList[u]) {
            int v = pr.first;
            LL w = pr.second;

            if(cost[u] + w < cost[v]) {
                cost[v] = cost[u] + w;
                pq.push(ii(cost[v], v));
            }
        }
    }

    return cost[t];
}


int main()
{
    //freopen("in.txt", "r", stdin);

    int k;
    scanf("%d", &k);

    while(k--) {
        adjList.clear();

        int n, r, s, d;
        scanf("%d %d %d %d", &n, &r, &s, &d);

        adjList.resize(n+3);

        int u, v, w;

        while(r--) {
            scanf("%d %d %d", &u, &v, &w);
            w += 12;
            adjList[u].push_back(ii(v, w));
            adjList[v].push_back(ii(u, w));
        }

        printf("%lld\n", dijkstra(n, s, d));
    }

    return 0;
}