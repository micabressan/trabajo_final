#include<bits/stdc++.h>
#define int long long
using namespace std;
int dx[5]{0,0,1,-1};//массивы нужны чтобы укоротить код и написать только один оператор условия 
int dy[5]{1,-1,0,0};
main()
{
    int n,m,a,b,x,y;
    cin>>m>>n;
    string s[510];
    for (register int i=1;i<=m;i++)
        cin>>s[i];
    priority_queue<pair<int,pair<int,int> > >q;//priority_queue сортируется по убыванию. 
    int d[501][501];
    q.push({0,{1,1}});//0-вес текущего пути и 1;1- координаты начальной точки 
    for (register int i=1;i<=m;i++)
    for (register int j=1;j<=n;j++)d[i][j]=1e9;
    d[1][1]=0;
    while (!q.empty()){
        a=q.top().second.first;
        b=q.top().second.second;//вытаскиваем координаты текущей вершины
        q.pop();
        int k=s[a][b-1]-'0';//узнаем какая цифра стоит на этом месте
        for (register int i=0;i<=3;i++)//так как 4 направления 
            if(a+k*dx[i]>=1&&a+k*dx[i]<=m&&b+k*dy[i]>=1&&b+k*dy[i]<=n)//тоже самое что и ваша функция (is)
            if(d[a+k*dx[i]][b+k*dy[i]]>d[a][b]+1){
                d[a+k*dx[i]][b+k*dy[i]]=d[a][b]+1;
                q.push({-d[a+k*dx[i]][b+k*dy[i]],{a+k*dx[i],b+k*dy[i]}});//расстояние с минусом потому что  priority_queue сортирует по убыванию.
            }
    }
    if(d[m][n]==1e9)cout<<"IMPOSSIBLE";
    else
    cout<<d[m][n];
}