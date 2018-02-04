// ldc2.exe -release -m64 -O wc.d

import std.stdio;
import std.uni;

void main()
{
    int words, lines, chars, state;
    
    foreach(line; stdin.byLine()) {
        lines++;
        state = 0;
        foreach(dchar c; line) {
            final switch(state) {
            case 0: // wait for start of word
                if (isAlpha(c)) { chars++; state = 1; }
                break;
            case 1: // we're reading word - wait for end
                if (isAlpha(c))
                    chars++;
                else {
                    words++;
                    state = 0;
                }
            }
        }
        if (state == 1) words++;
    }
    writefln(`Lines=%s words=%s chars=%s`, lines, words, chars);
}