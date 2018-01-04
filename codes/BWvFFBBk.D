// ldc2.exe -release -m64 -O strcat.d

import std.stdio;
import std.conv;

void main(string[] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    string hello;

    for (int i = 0; i < n; i++)
        hello ~= "hello\n";

    writeln(hello.length);
}