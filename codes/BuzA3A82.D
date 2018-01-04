        Socket connect (Address addr)
        {
			version (TangoRuntime)
			{ 
				if (scheduler)
					asyncConnect (addr);
				else
					native.connect (addr);
			}
			else
			{
				native.connect (addr);
			}
                return this;
        }