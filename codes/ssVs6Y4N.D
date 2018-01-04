try
{
	character character;

	character = character("eu", "Aerie%20Peak", "Khedra");
	writeln(format("%s: %s", character.name, character.achievement_points));
}
catch(Exception e)
{
	writefln("blah");
	writefln("Exception: %s", e.msg);
}