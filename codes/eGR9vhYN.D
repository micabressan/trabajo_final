import std.string;

void main()
{
    char[16] buf;
    for (int i = 0; i < 10000000; i++)
        sformat(buf, "%d %s %f", 5, "foo", 3.14f);
}