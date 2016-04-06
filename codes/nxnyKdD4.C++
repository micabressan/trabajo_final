#pragma comment(linker, "/STACK:16777216")
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cstdio>
#include <algorithm>
#include <functional>
#include <vector>
#include <cmath>
#include <queue>
#include <string>

using namespace std;

vector <long long> a;
vector <long long> tree;
vector <long long> mdf;

vector <int> tIn;
vector <int> tOut;

void push(int v, int tl, int tr){
	if(tl + 1 == tr){
		tree[v] += mdf[v];
		mdf[v] = 0;
		return ;
	}

	mdf[2 * v + 1] += mdf[v];
	mdf[2 * v + 2] += mdf[v];
	tree[v] += mdf[v] * (tr - tl);
	mdf[v] = 0;
	return ;
}

void inc(int v, int tl, int tr, int delta, int l, int r){
	if(tl == l && tr == r){
		mdf[v] += delta;
		push(v, tl, tr);
		return ;
	}
	push(v, tl, tr);
	int m = (tl + tr)  / 2;
	if(r <= m){
		inc(2 * v + 1, tl, m, delta, l, r);
	}
	else if(l >= m){
		inc(2 * v + 2, m, tr, delta, l, r);
	}else{
		inc(2 * v + 1, tl, m, delta, l, m);
		inc(2 * v + 2, m, tr, delta, m, r);
	}
	tree[v] = tree[2 * v + 1] + mdf[2 * v + 1] * (m - tl) + tree[2 * v + 2] + mdf[2 * v + 2] * (tr - m);
}

long long query(int v, int tl, int tr, int l, int r){
	push(v, tl, tr);
	if(tl == l && tr == r){
		return tree[v];
	}
	int m = (tl + tr) / 2;
	if(r <= m) return query(2 * v + 1, tl, m, l, r);
	if(l >= m) return query(2 * v + 2, m, tr, l, r);
	return query(2 * v + 1, tl, m, l, m) + query(2 * v + 2, m, tr, m, r);
}

vector <vector <int> > g;

void DFS(int v, int t){
	tIn[v] = t;
	tOut[v] = tIn[v] + 1;
	for(int i = 0; i < static_cast<int>(g[v].size()); ++i){
		DFS(g[v][i], tOut[v]);
		tOut[v] = tOut[g[v][i]];
	}
}

int main(){
	//freopen("input.txt", "r", stdin);
	//freopen("output.txt", "w", stdout);

	int n, q;
	long long s0;
	cin >> n >> q >> s0;
	a.assign(n, 0);
	tree.assign(4 * n, 0);
	mdf.assign(4 * n, 0);
	g.resize(n);

	int b, s;
	a[0] = s0;
	for(int i = 1; i < n; ++i){
		cin >> b >> s;
		g[b].push_back(i);
		a[i] = s;
	}
	tIn.resize(n);
	tOut.resize(n);
	DFS(0, 0);

	for(int i = 0; i < n; ++i){
		inc(0, 0, n, a[i], tIn[i], tIn[i] + 1);
	}

	string ss;
	long long x, y, z;
	for(int i = 0; i < q; ++i){
		cin >> ss >> x >> y >> z;
		if(ss == "employee"){
			if(query(0, 0, n, tIn[x], tIn[x] + 1) < y){
				inc(0, 0, n, z, tIn[x], tIn[x] + 1);
			}
		}else {
			if(query(0, 0, n, tIn[x], tOut[x]) < y * (tOut[x] - tIn[x])){
				inc(0, 0, n, z, tIn[x], tOut[x]);
			}
		}
	}

	for(int i = 0; i < n; ++i){
		cout << query(0, 0, n, tIn[i], tIn[i] + 1) << endl;
	}
	return 0;
}