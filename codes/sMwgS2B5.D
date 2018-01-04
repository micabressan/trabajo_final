	private type get(size_t coord)() @property
	{
		return vector[coord];
	}

	alias get!0 x;
	alias get!1 y;

	static if(dimension >= 3)
		alias get!2 z;

	static if(dimension >= 4)
		alias get!3 w;