#include<iostream>
#include<sstream>
#include<string>
#include<cstdlib>
#include<vector>
#include<map>
#include<queue>
#include<stack>
#include<cmath>
#include<cctype>
#include<set>
#include<bitset>
#include<algorithm>
#include<list>

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
#include<ctype.h>

using namespace std;
#define print1(a)    cout<<a<<endl
#define print2(a,b) cout<<a<<" "<<b<<endl
#define print3(a,b,c) cout<<a<<" "<<b<<" "<<c<<endl
#define oo          (1<<30)
#define PI          3.141592653589793
#define pi          2*acos(0)
#define ERR         1e-5
#define PRE         1e-8
#define SZ          size()
#define LL          long long
#define ISS         istringstream
#define OSS         ostringstream
#define VS          vector<string>
#define VI          vector<int>
#define VD          vector<double>
#define VLL         vector<long long>
#define SII         set<int>::iterator
#define SI          set<int>
#define mem(a,b)    memset(a,b,sizeof(a))
#define fr(i,a,b)   for(i=a;i<=b;i++)
#define frn(i,a,b)  for(i=a;i>=b;i--)
#define fri(a,b)    for(i=a;i<=b;i++)
#define frin(a,b)   for(i=a;i>=b;i--)
#define frj(a,b)    for(j=a;j<=b;j++)
#define frjn(a,b)   for(j=a;j>=b;j--)
#define frk(a,b)    for(k=a;k<=b;k++)
#define frkn(a,b)   for(k=a;k>=b;k--)
#define frl(a,b)    for(l=a;l<=b;l++)
#define frln(a,b)   for(l=a;l>=b;l--)

#define EQ(a,b)     (fabs(a-b)<ERR)
#define all(a,b,c)  for(int I=0;I<b;I++)    a[I] = c
#define CROSS(a,b,c,d) ((b.x-a.x)*(d.y-c.y)-(d.x-c.x)*(b.y-a.y))
#define sqr(a)      ((a)*(a))
#define FORE(i,a)   for(typeof((a).begin())i=(a).begin();i!=(a).end();i++)
#define BE(a)       a.begin(),a.end()
#define rev(a)      reverse(BE(a));
#define sorta(a)    sort(BE(a))
#define pb          push_back
#define popb        pop_back
#define round(i,a)  i = ( a < 0 ) ? a - 0.5 : a + 0.5;
#define makeint(n,s)  istringstream(s)>>n
#define mo          100010
//1 based
//Just need to insert input in arredge.
//The vertices order is not important that means you just have to enter every edge only once.

typedef struct edges{
    int n1;
    int n2;
    int w;
}ed;
ed arredge[mo];
int p[mo];
int rank[mo];
int settree;

void makeset(int node)  //initialize
{
    p[node]=node;
}

void link(int x,int y)
{
    if(rank[x]>rank[y])
        p[y]=x;
    else
        p[x]=y;
    if(rank[x]==rank[y])
        rank[y]++;
}

int findset(int node)  //giving value recursively(once done then query O(1))
{
    if(node!=p[node])
        p[node]=findset(p[node]);
    return p[node];
}

bool comp(ed x,ed y)
{
    return x.w<y.w;
}

void initialize(int node)
{
    for(int i=1;i<=node;i++)//1 indexed node
            makeset(i);
    mem(rank,0);
}

int mst(int st,int end,int node)//look at the sort for information about the parameters
{
        if(st<=end)
        sort(&arredge[st],&arredge[end+1],comp);
        initialize(node);
        int in=st,i;
        settree=node;
        int edgecost=0;
        while(settree!=1)/*change in this can change mst*/
        {
            int c,d;
            c=findset(arredge[in].n1);
            d=findset(arredge[in].n2);
            if(c!=d)
            {
                cout<<c<<" "<<d<<endl;
				settree--;
                link(c,d);
                
                edgecost+=arredge[in].w;
            }
            in++;
        }
        return edgecost;
}


int main()
{
    int m,n;

    while(cin>>n>>m)
    {
        int i,a,b,we;
        for(i=1;i<=m;i++)
        {
            cin>>a>>b>>we;
            arredge[i].n1=a;
            arredge[i].n2=b;
            arredge[i].w=we;
        }

        int edgecost=mst(1,m,n);
        cout<<edgecost<<endl;
    }
    return 0;
}