int[char[]] a;
int[immutable(char[])] b;

void main()
{
	char[] s;
	a.remove(s);
	b.remove(s); //Error: cannot implicitly convert expression (s) of type char[] to immutable(char[])
}