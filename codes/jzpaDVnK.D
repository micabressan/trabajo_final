// ldc2.exe -release -m64 -O sieve.d

import std.stdio;
import std.conv;

void main(string[] args)
{
    int n = args.length < 2 ? 1 : to!int(args[1]);
    char[8192 + 1] flags;
    int count = 0;

    while (n--) {
        count = 0; 
        for (int i = 2; i <= 8192; i++)
            flags[i] = 1;

        for (int i = 2; i <= 8192; i++) {
            if (flags[i]) {
                // remove all multiples of prime: i
                for (int k = i+i; k <= 8192; k += i)
                flags[k] = 0;
                count++;
            }
        }
    }
    writeln(count);
}