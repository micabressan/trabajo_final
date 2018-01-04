class Base(T)
{
public:	
	S add(S : T)(S child){return child;}
	//void add(T){}
}

class Foo
{}

class Bar : public  Base!Bar
{
public: 	
	alias Base!Bar.add!Bar add;
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
	main.d(14): Error: alias main.Bar.add conflicts with function main.Bar.add at main.d(15)
	*/
}