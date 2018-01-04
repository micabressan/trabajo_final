// ldc2.exe -release -m64 -O fibo.d

import std.conv;
import std.stdio;

uint fib(uint n)
{
    return n < 2 ? 1 : fib(n-2) + fib(n-1);
}

void main(string[] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    writeln(fib(n));
}