// ldc2.exe -release -m64 -O matrix.d

import std.stdio;
import std.conv;

const int SIZE = 30;

void init_matrix(ref int[SIZE][SIZE] m) {
    int count = 1;
    for (int i=0; i < SIZE; i++)
        for (int j=0; j < SIZE; j++) {
            m[i][j] = count++;
        }
}

void mmult(ref int[SIZE][SIZE] m1, ref int[SIZE][SIZE] m2, ref int[SIZE][SIZE] m3)
{
    for (int i=0; i < SIZE; i++) {
        for (int j=0; j < SIZE; j++) {
            int val = 0;
            for (int k=0; k < SIZE; k++) {
                val += m1[i][k] * m2[k][j];
            }
            m3[i][j] = val;
        }
    }
}

void main(string[] args) {        
    int n = args.length < 2 ? 1 : to!int(args[1]);
    
    int[SIZE][SIZE] m1, m2, mm;
    init_matrix(m1);
    init_matrix(m2);

    for (int i=0; i < n; i++)
        mmult(m1, m2, mm);
    
    writefln(`%s %s %s %s`, mm[0][0], mm[2][3], mm[3][2], mm[4][4]);
}