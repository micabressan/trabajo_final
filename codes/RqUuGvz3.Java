#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

typedef unsigned long long int big;


big comb[51][51];

void setupPascalTriangle() {
    for(int y=0; y<=50; y++)
        comb[y][0] = 1;
    comb[1][1] = 1;
    for(int y=2; y<=50; y++) {
        for(int x=1; x<=50; x++) {
            comb[y][x] = comb[y-1][x-1] + comb[y-1][x];
        }
    }
}

vector<int> foundCombination(vector<int> &weights, int weight, int k) {
    vector<int> positions;
    int i=weights.size()-1;
    while(k > 0) {
        int biggest = i;
        for(; i>=(k-1); i--) {
            if(weight >= weights[i]) {
                biggest = i;
                break;
            }
        }
        positions.push_back(biggest);
        weight -= weights[biggest];
        i = biggest-1;
        k--;
    }
    return positions;
}


big foundCombFromLeft(vector<int> &positions, int s, int k, int i, int p) {
    if(p >= positions.size()) return 0;
    big total = 0;
    for(; i<positions[p]; i++)
        total += comb[s-i-1][k - 1];
    return total + foundCombFromLeft(positions, s, k-1, i+1, p+1);;
}

big foundCombFromRight(vector<int> &positions, int s, int k, int i, int p) {
    if(p >= positions.size()) return 0;
    big total = 0;
    for(; i>positions[p]; i--)
        total += comb[i][k - 1];
    return total + foundCombFromRight(positions, s, k-1, i-1, p+1);
}

int main()
{
    // Setuo pascal triangle
    setupPascalTriangle();

    // Test cases
    int t;
    cin >> t;
    for(int i=0; i<t; i++) {

        // Get Inputs
        int group, by;
        int _min, _max;
        cin >> group >> by;
        vector<int> weights;
        int w;
        for(int j=0; j<group; j++) {
            cin >> w;
            weights.push_back(w);
        }
        sort(weights.begin(), weights.end());
        cin >> _min >> _max;


        // Solve
        vector<int> positionsL = foundCombination(weights, _min, by);
        vector<int> positionsR = foundCombination(weights, _max, by);

        // Sort from left
        sort(positionsL.begin(), positionsL.end());

        // Calculate
        int solution = comb[group][by];
        solution -= foundCombFromLeft(positionsL, weights.size(), by, 0, 0);
        solution -= foundCombFromRight(positionsR, weights.size(), by, weights.size()-1, 0);
        cout << solution << endl;
    }
    return 0;
}