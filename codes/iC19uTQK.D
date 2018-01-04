import std.stdio;

void Function_Accept_uint16(ushort parameter)
{
	return;
}


void main()
{
	ushort number=0x1000;
	
	Function_Accept_uint16(number); //Works

	
	Function_Accept_uint16(number+1);
	/*
	source\app.d(16,24): Error: function app.Function_Accept_uint16 (ushort paramete
	r) is not callable using argument types (int)
	dmd failed with exit code 1.
	*/
}