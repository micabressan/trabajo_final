class Base(T)
{
public:	
	//S add(S : T)(S child){return child;}
	void add(T){}
}

class Foo
{}

class Bar : public  Base!Bar
{
public: 	
	void add(Foo f){}
}


void main()
{
	Bar b = new Bar();
	Bar b2 = new Bar();
	Foo f = new Foo();
	b.add(f);
	b.add(b2);
	/*
	main.d(24): Error: function main.Bar.add (Foo f) is not callable using argument types (Bar)
	main.d(24): Error: cannot implicitly convert expression (b2) of type main.Bar to main.Foo
	*/
}