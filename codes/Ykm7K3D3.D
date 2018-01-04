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

test4.d(8): Error: module test4 std.stdio.writefx is private
test4.d(8): Error: function std.stdio.writefx (shared(_iobuf)* fps, TypeInfo[] arguments, void* argptr, int newline = cast(int)false) is not callable using argument types (File,TypeInfo[],void*,int)
test4.d(8): Error: function stdio.writefx is not accessible from test4
test4.d(8): Error: cannot implicitly convert expression (stdout) of type File to shared(_iobuf)*