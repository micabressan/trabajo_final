import std.stdio;

struct Vector(type, int dim) if(dim > 1)
{
	alias dim dimension;
	type[dim] vector;

	static void isCompatibleVectorImpl(int d)(Vector!(type, d) vec) if(d <= dim)
	{
	}

	template isCompatibleVector(T)
	{
		enum isCompatibleVector = is(typeof(isCompatibleVectorImpl(T.init)));
	}

	void construct(int i, T, Tail...)(T head, Tail tail)
	{
		static if(i >= dim)
			static assert(false, "constructor has too many arguments");
		else static if(is(T : type))
		{
			vector[i] = head;
			construct!(i + 1)(tail);
		}
		else static if(isCompatibleVector!T)
		{	
			foreach(j; i .. i + T.dimension)
				vector[j] = head.vector[j];
			construct!(i + T.dimension)(tail);
		}
		else
			static assert(false, "Vector constructor argument must be of type " ~ type.stringof ~ " or Vector, not " ~ T.stringof);
	}
	
	void construct(int i)() // terminate
	{
	}

	this(Args...)(Args args)
	{
		construct!(0)(args);
	}
}

alias Vector!(float, 2) vec2;
alias Vector!(float, 3) vec3;
alias Vector!(float, 4) vec4;

void main()
{
	auto v2 = vec2(1.0, 1.0);
	writeln(v2.vector);
	
	auto v3 = vec3(v2, 2.0);
	writeln(v3.vector);
	
	auto v4 = vec4(1, vec2(2, 3), 4);
	writeln(v4.vector);
	
	// Fails graciously:
		//Vector!(float, 1)(1.0); // Too small dimension
		//vec2("strings", "are not allowed"); // Incompatible type
		//vec2(1.0, 1.0, 1.0); // Too many arguments
		//vec3(1, vec2(2, 3), 4); // Too many arguments
}