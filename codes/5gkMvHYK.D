// ldc2.exe -release -m64 -O hash.d

import std.stdio;
import std.conv;

void main(string[] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    int[string] X;
    
    for(int i=1; i<=n; i++)
        X[to!string(i, 16)] = i;
   
    int c = 0;   
    for(int i=n; i>0; i--)
        if(to!string(i) in X) c++;

    writeln(c);
}