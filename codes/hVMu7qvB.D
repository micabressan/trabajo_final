// ldc2.exe -release -m64 -O nestedloop.d

import std.stdio;
import std.conv;

void main(string[] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    ulong x=0;

    for (int a=0; a<n; a++)
        for (int b=0; b<n; b++)
            for (int c=0; c<n; c++)
                for (int d=0; d<n; d++)
                    for (int e=0; e<n; e++)
                        for (int f=0; f<n; f++)
                            x++;

    writeln(x);
}