import std.stdio;

int delegate() test()
{
	int a = 0;
	auto del = 
	{
		a++;
		return a;
	};
	
	del();
	writeln(a); //prints 1
	
	return del;
}

void main()
{
	auto del = test();
	writeln(del()); //prints 2
	writeln(del()); //prints 3
}