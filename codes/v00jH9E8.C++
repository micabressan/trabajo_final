#include<bits/stdc++.h>
 
#define LL long long 
#define sn(n) scanf("%d",&n) ;
#define slld(n) scanf("%lld",&n) ;
#define sc(n) scanf(" %c",&n) ;
#define ss(n) scanf(" %s",n) ;
#define all(n) n.begin() , n.end()
#define pb push_back
#define vi vector<int> 
#define vLL vector<LL >
#define vvi vector<vi >
#define vvLL vector<vLL >
#define vc vector<char>
#define vvc vector<vc >
#define vb vector<bool>
#define vvb vector<vb > 
#define pii pair<int , int> 
#define fi first 
#define se second
#define mp make_pair
#define vpii vector<pii >
#define vvpii vector<vpii >
#define rep(i , a , b) for(int (i) = (a) ; (i) < (b) ; ++(i))
#define rev(i , a , b) for(int (i) = (a)-1 ; (i) >= (b) ; --(i))
#define tr(container , it) for(typeof(container.begin()) it = container.begin() ; it != container.end() ; ++it)
#define mii map<int , int>
#define msi map<string , int>
#define mci map<char , int>
#define INF (1<<31)
#define fast_io ios::sync_with_stdio(0) ; cin.tie(0) ; 
#define max_array 1000000
#define in() freopen("input.txt" , "r" , stdin) ;
#define out() freopen("output.txt" , "w" , stdout) ;
#define MOD 1000000007
#define debug() cout << "HI" << endl ;

#define gc() getchar() //Change to getchar() in codeforces.com

#define type int

using namespace std ;

inline type read() //Change to long long to int or anything
{
    type x = 0 ;
    char temp ;
    temp = gc() ;
    while(temp < 48 )
    {
        temp = gc() ;
    }
    x += (temp-'0') ;
    temp = gc() ;
    while(temp >= 48)
    {
        x = (x<<3) + (x<<1) + (temp - '0') ;
        temp = gc() ;
    }
    return x ;
}

int n, m ;
vector<vector<int > > graph ;
vector<vector<int > > graphRev ;
vector<int> finish;
int disc[10000] ;
int scc[10000] ;
int t ;
set<int> s ;

void dfsRev(int u)
{
    disc[u] = 0 ;
    for(int i = 0; i < graphRev[u].size(); ++i)
    {
        int v = graphRev[u][i] ;
        if(disc[v] == -1)
        {
            dfsRev(v) ;
        }
    }
    finish.pb(u) ;
}

void dfs(int u)
{
    disc[u] = 0 ;
    for(int i = 0; i < graph[u].size(); ++i)
    {
        int v = graph[u][i] ;
        if(disc[v] == -1)
        {
            dfs(v) ;
        }
    }
    scc[u] = t ;
}

int main()
{
    // fast_io ;
    int test ;
    test = read() ;
    
    while(test--)
    {
        int ans = 0 ;
        graph.clear() ;
        graphRev.clear() ;
        finish.clear() ;
        t = 0 ;
        s.clear() ;
        
        n = read() ;
        graph.resize(n) ;
        graphRev.resize(n) ;
        
        memset(disc, -1, sizeof disc) ;
        memset(scc, -1, sizeof scc) ;
        
        for(int i = 0; i < n; ++i)
        {
            char str[n] ;
            scanf("%s", str) ;
            
            for(int j = 0; j < n; ++j)
            {
                if(str[j] == 'Y')
                {
                    graph[i].pb(j) ;
                    graphRev[j].pb(i) ;   
                }
            }
        }
        
        for(int i = 0; i < n; ++i)
            if(disc[i] == -1)
                dfsRev(i) ;
        
        reverse(all(finish)) ;
        memset(disc, -1, sizeof disc); 
        
        for(int i = 0; i < n; ++i)
        {
            if(disc[finish[i]] == -1)
            {
                dfs(finish[i]) ;
                t++ ;
            }
        }
        for(int i = 0; i < n; ++i)
        {
            
            for(int j = 0; j < graph[i].size(); ++j)
            {
                
                int v = graph[i][j] ;
                if(scc[i] != scc[v])
                    s.insert(scc[v]) ;
            }
        }
        
	printf("%d\n", t) ;
    }
    
    return 0 ;
}