static import Math = std.math;
import stdio = std.stdio;

struct std
{
	struct math
	{
		static T pow(T)(T a, T b)
		{
			return a - b;
		}
	}
}

void main()
{
	auto a = 2.0^^3.1;
	stdio.writeln(a); //-1.1
}