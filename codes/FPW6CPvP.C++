//
//  main.cpp
//  stepic
//
//  Created by Андрей Решетников on 08.09.17.
//  Copyright © 2017 Андрей Решетников. All rights reserved.
//
#include <set>
#include <cstdlib>
#include <random>
#include <vector>
#include <algorithm>
#include <iostream>
#include <complex>
#include <iomanip>
#include <string>
#include <map>

using namespace std;
const double EPS = 1E-24;

int main(int argc, const char * argv[]) {
    double param;
    cin >> param;
    int n;
    cin >> n;
    map<string, vector<string>> graph;
    map<string, int> time_in;
    for(int i = 0; i < n; i++) {
        string s1, s2;
        cin >> s1 >> s2;
        graph[s1].push_back(s2);
        if (time_in.find(s1) == time_in.end()) {
            time_in[s1] = (int)time_in.size();
        }
        if (time_in.find(s2) == time_in.end()) {
            time_in[s2] = (int)time_in.size();
        }
    }
    
    auto column = vector<double>(time_in.size(), 0.0);
    auto matrixA = vector<vector<double>>(time_in.size(), column);
    
    for(auto it = time_in.begin(); it != time_in.end(); it++) {
        vector<string> values = graph[it->first];
        if (values.size() == 0) {
            for(int i = 0; i < time_in.size(); i++) {
                matrixA[it->second][i] = 1.0 / time_in.size();
            }
        } else {
            for(int j = 0; j < values.size(); j++) {
                matrixA[it->second][time_in[values[j]]] = 1.0 / values.size();
            }
        }
    }
    
    column = vector<double>(time_in.size(), 0.0);
    auto matrixM = vector<vector<double>>(time_in.size(), column);
    for(int i = 0; i < time_in.size(); i++)
        for(int j = 0; j < time_in.size(); j++)
            matrixM[i][j] = (1 - param) * matrixA[i][j] + param * (1.0 / time_in.size());
    
    vector<double> mul = vector<double>(time_in.size(), 1.0 / time_in.size());
    vector<double> multiply = mul;
    for(int i = 0; i < 1000; i++) {
        for(int j = 0; j < time_in.size(); j++) {
            double sum = 0.0;
            for(int k = 0; k < time_in.size(); k++) {
                sum += matrixM[k][j] * mul[k];
            }
            multiply[j] = sum;
        }
        
        
        bool flag = true;
        for(int j = 0; j < mul.size(); j++) {
            if (abs(multiply[j] - mul[j]) > EPS) {
                flag = false;
                break;
            }
        }
        if (flag) {
            break;
        }
        
        mul = multiply;
    }
    double sum = 0.0;
    for(int i = 0; i < mul.size(); i++) {
        sum += mul[i];
    }
    for(int i = 0; i < mul.size(); i++) {
        mul[i] /= sum;
    }
    for(auto it = time_in.begin(); it != time_in.end(); it++) {
        if (it->second < mul.size()) {
            cout << setprecision(16) << it->first << " " << mul[it->second] << endl;
        }
    }
    return 0;
}