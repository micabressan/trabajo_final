// ldc2.exe -release -m64 -O ackermann.d

import std.stdio;
import std.conv;

int Ack(int M, int N)
{
    if (M == 0) return N + 1;
    if (N == 0) return Ack(M - 1, 1);
    return Ack(M - 1, Ack(M, (N - 1)));
}

void main(string[] args)
{
   int n = args.length < 2 ? 1 : to!int(args[1]);
   writefln(`Ack(3, %s): %s`, n, Ack(3, n));
}