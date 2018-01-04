import std.stdio;

import core.vararg;



void print(...)

{

    foreach (arg; _arguments)

    {

		writefx(stdout, (&arg)[0 .. 1], _argptr, 1);

		auto size = arg.tsize();

		_argptr += ((size + size_t.sizeof - 1) & ~(size_t.sizeof - 1));

    }

}



int main(char[][] args)

{

	print(5, 6, 7);

	return 0;

}