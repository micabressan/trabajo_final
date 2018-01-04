import std.stdio;
import std.algorithm.searching : find;
import std.concurrency;
import core.atomic;

shared int x;

int main(string[] argv)
{
    x += 1;   // здесь варнинг
    writeln(x);

    atomicOp!"+="(x, 10);
    writeln(x);

    return 0;
}

/*
Performing "debug" build using dmd for x86_64.
test ~master: building configuration "application"...
source/app.d(10,5): Deprecation: read-modify-write operations are not allowed for shared variables. Use core.atomic.atomicOp!"+="(x, 1) instead.
Linking...
Running ./test 
1
11
*/