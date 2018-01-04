void test (const(char)[] format, S...)(S arguments)
{

}



int main(char[][] args)
{
	test("foobar", 1, 2, 3);
	return 0;
}

// dmd test4.d 
// test4.d(8): Error: template test4.test(const(char)[] format,S...) does not match any function template declaration
// test4.d(8): Error: template test4.test(const(char)[] format,S...) cannot deduce template function from argument types !()(string,int,int,int)