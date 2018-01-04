#include<bits/stdc++.h>
using namespace std;
#define n 1000
#define pb push_back
vector<int>nd[1000];
bool visit[n];
int colour[n];


bool bfs(int s)
{
    int i,u;

    queue<int>q;
    colour[s]=1;
    q.push(s);

    while(!q.empty())
    {
        s=q.front();
        q.pop();
        for(i=0; i<nd[s].size(); i++)
        {
            u=nd[s][i];
            if(colour[u]==-1)
            {
                colour[u]=1-colour[s];
                q.push(u);
            }
            else if(colour[u]==colour[s]) return false;
        }
    }
    return true ;
}



int main()
{
    int m,a,b,i,f,t,j;
    cin>>t;
    for(j=0; j<t; j++)
    {
        
        int flag=0;
        cin>>f>>m;

        for(i=0; i<m; i++)
        {

            cin>>a>>b;
            nd[a].pb(b);
            nd[b].pb(a);

        }


        for(i=0; i<n; i++)
        {
            colour[i]=-1;
        }
        for(i=1; i<=n; i++)
        {
            if(colour[i]== -1)
            {
                //res=bfs(i);
                if(bfs(i)==false)
                {
                    flag=1;
                    break;
                }
            }
        }
        if(flag==1)
            printf("Scenario #%d:\nSuspicious bugs found!\n",j+1);
        else
            printf("Scenario #%d:\nNo suspicious bugs found!\n",j+1);
    }
    return 0;
}