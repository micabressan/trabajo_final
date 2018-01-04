#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

bool ordre(string a, string b){
    return (a < b);
}

int main(){
    int n;
    while (cin >> n){
        vector<string> v(n);
        //input
        for (int i = 0; i < n; i++){
            cin >> v[i];
        }
        //sort
        sort(v.begin(), v.end(), ordre);
        
        vector<int> w(n, 0);
        
        //processing
        string last_word = "";
        int reps = 1;
        for (int i = 0; i < n; i++){
            if (v[i] == last_word){
                reps++;
            }
            else{
                w[reps] += last_word.length();
                reps = 1;
                last_word = v[i];
            }
        }
        w[reps] += last_word.length();

        
        //output
        int size = w.size();
        for (int i = 0; i < size; i++){
            if (w[i] != 0) cout << i << " : " << w[i] << endl;
        }
        cout << endl;
        
    }
}