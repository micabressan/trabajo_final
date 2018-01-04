template coordToIndex(char c)
	{
		static if(c == 'x')
			enum coordToIndex = 0;
		else static if(c == 'y')
			enum coordToIndex = 1;
		else static if(c == 'z')
		{
			static assert(dimension >= 3, "the z property is only available on vectors with a third dimension.");
			enum coordToIndex = 2;
		}
		else static if(c == 'w')
		{
			static assert(dimension >= 4, "the w property is only available on vectors with a fourth dimension.");
			enum coordToIndex = 3;
		}
		else
			static assert(false, "accepted coordinates are x, y, z and w, not " ~ c ~ ".");
	}
	
	void dispatchImpl(size_t i, string s, size_t size)(ref t[size] result)
	{
		static if(s.length > 0)
		{
			result[i] = vector[coordToIndex!(s[0])];
			dispatchImpl!(i + 1, s[1..$])(result);
		}
	}

	t[s.length] opDispatch(string s)() {
		t[s.length] ret;
		dispatchImpl!(0, s)(ret);
		return ret;
	}