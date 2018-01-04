import std.stdio;
int foo(int *bar) { return 4**bar; }
void main ()
{
    int a = 4;
    writeln("FOO: ", foo(&a));
}