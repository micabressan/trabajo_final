        Socket connect (Address addr)
        {
		version (TangoRuntime)
		{ 
			if (scheduler) {
			        asyncConnect (addr);
                                return this;
                        }
		}

		native.connect (addr);
                return this;
        }