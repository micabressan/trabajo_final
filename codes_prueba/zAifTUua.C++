#include<bits/stdc++.h>
using namespace std;
int vertical(int a[][100], int b[][100], int n);
int horizontal(int a[][100], int b[][100], int n);
int dkiri(int a[][100], int b[][100], int n);
int dkanan(int a[][100], int b[][100], int n);

int a[100][100];
int b[100][100];

int main(){
    int n, m;
    cin>>n>>n;

    int i, j;
    for(i = 0; i < n; i++){
        for(j = 0; j < n; j++){
            cin>>a[i][j];
        }
    }
    cin>>m>>m;
    int ide = 1;
    if(n != m){
        cout<<"tidak identik\n";
        return 0;
    }
    for(i = 0; i < m; i++){
        for(j = 0; j < m; j++){
            cin>>b[i][j];
            if(a[i][j] != b[i][j]) ide = 0;
        }
    }
    if(ide == 1) cout<<"identik\n";
    else{
        if(vertical(a,b,n)) cout<<"vertical\n";
        else if(horizontal(a,b,n)) cout<<"horizontal\n";
        else if(dkiri(a,b,n)) cout<<"diagonal kiri bawah\n";
        else if(dkanan(a,b,n)) cout<<"diagonal kanan bawah\n";
        else cout<<"tidak identik\n";
    }
    return 0;
}

int vertical(int a[][100], int b[][100], int n){
    int i, j;
    for(i = 0; i < n; i++){
        for(j = 0; j <= n/2; j++){
            if(a[i][j] != b[i][n-1-j]) return 0;
        }
    }
    return 1;
}

int horizontal(int a[][100], int b[][100], int n){
    int i, j;
    for(i = 0; i <= n/2; i++){
        for(j = 0; j < n; j++){
            if(a[i][j] != b[n-1-i][j]) return 0;
        }
    }
    return 1;
}

int dkiri(int a[][100], int b[][100], int n){
    int i, j;
    for(i = 0; i < n; i++){
        for(j = 0; j < n-1-i; j++){
            if(a[i][j] != b[n-1-j][n-1-i]) return 0;
        }
    }
    return 1;
}

int dkanan(int a[][100], int b[][100], int n){
    int i, j;
    for(i = 0; i < n; i++){
        for(j = 0; j < i; j++){
            if(a[i][j] != b[j][i]) return 0;
        }
    }
    return 1;
}