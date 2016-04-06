#include <iostream>
#include <vector>
#include <stdio.h>
using namespace std;


vector<int> adj[1001001];
bool del[1001001];
int sum[1001001];
int n;
int a,b;

int find_center(int nd,int p,int sz){
	for(int i=0;i<adj[nd].size();i++){
		int ch=adj[nd][i];
		if(ch==p || del[ch])continue;
		if(sum[ch]*2>sz)
			return find_center(ch,nd,sz);
	}
	return nd;
}
void find_sum(int nd,int p){
	sum[nd]=1;
	for(int i=0;i<adj[nd].size();i++){
		int ch=adj[nd][i];
		if(ch==p || del[ch])continue;
		find_sum(ch,nd);
		sum[nd]+=sum[ch];
	}
}


int main(){
	scanf("%d",&n);
	for(int i=1;i<=n;i++){
		del[i]=false;
	}
	for(int i=1;i<n;i++){
		scanf("%d %d",&a,&b);
		adj[a].push_back(b);
		adj[b].push_back(a);
	}
	int curr=1;
	while(true){
		find_sum(curr,curr);
		int t=find_center(curr,curr,sum[curr]);
		cout<<t<<endl;
		del[t]=true;
		cin>>curr;
		if(curr==0)break;
	}
}