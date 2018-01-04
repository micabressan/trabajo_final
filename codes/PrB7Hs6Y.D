// ldc2.exe -release -m64 -O hash2.d

import std.conv;
import std.stdio;

void main(char[][] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    char[32] buf;
    int[string] ht1;
    int[string] ht2;

    for (int i = 0; i <= 9999; i++)
        ht1[`foo_` ~ to!string(i)] = i;

    auto ks = ht1.keys;

    for (int i = 0; i < n; i++)
        for (int j = 0; j < ks.length; j++)
            ht2[ks[j]] += ht1[ks[j]];

    writefln(`%s %s %s %s`,
       ht1["foo_1"],
       ht1["foo_9999"],
       ht2["foo_1"],
       ht2["foo_9999"]);
}