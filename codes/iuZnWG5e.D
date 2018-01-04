// ldc2.exe -release -m64 -O randomd.d

import std.stdio;
import std.conv;

const int IM = 139968;
const int IA = 3877;
const int IC = 29573;

double gen_random(double max)
{
    static int last = 42;
    last = (last * IA + IC) % IM;
    return max * last / IM;
}

void main(string[] args)
{
    ulong n = args.length < 2 ? 1 : to!ulong(args[1]);
    double result = 0;
    
    while (n--)
        result = gen_random(100.0);

    writeln(result);
}