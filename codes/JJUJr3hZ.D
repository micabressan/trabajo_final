$ cat test.d
void test(scope void delegate(const(char)[][]...) emit)
{
	emit("test");
}

void main()
{
	
}

$ dmd test.d
Segmentation fault

$ dmd --help
DMD64 D Compiler v2.054