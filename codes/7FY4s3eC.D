module main;

import std.stdio, std.file, std.path, std.algorithm;

enum EqualBy {
	Size, Name
}

int main(string[] argv)
{
	string[] dirs;
    EqualBy equality = EqualBy.Size;
	
	foreach(int i, string arg; argv) {
        if (i == 0) continue;// skip program name
		switch(arg)
		{
		case `-s`: equality = EqualBy.Size; break;
		case `-n`: equality = EqualBy.Name; break;
        case `?`: PrintUsage(argv[0]); return 0;
        default: dirs ~= arg; break;
		}
	}
	
	FileInfo[][] files; files.length = dirs.length;
	// assemble all files in all specified directories
	foreach(int i, string dir; dirs) {
		foreach (string name; dirEntries(dir, SpanMode.breadth))
		{
			if (isDir(name)) continue;
			files[i] ~= FileInfo(basename(name), name, getSize(name));
		}
	}
	// find similar files from the first dir in another dirs
	foreach(FileInfo fi; files[0]) {
		for(int i=1; i < files.length; i++) {
			foreach(FileInfo fi2; files[i]) {
				if (fi.fullName == fi2.fullName) continue;
				if (endsWith(fi.name, ".db") || endsWith(fi.name, ".BUP") || endsWith(fi.name, ".IFO") || endsWith(fi.name, ".VOB")) continue;// skip DVD files
				
				if((equality == EqualBy.Size && (fi.size == fi2.size)) ||
				   (equality == EqualBy.Name && (fi.name == fi2.name)))
				{
					writeln(`EQ1: ` ~ fi.fullName);
					writeln(`EQ2: ` ~ fi2.fullName);
					writeln();
				}
			}
		}
	}
	
	return 0;
}

void PrintUsage(string programName)
{
    writeln("Find duplicates utility. Usage:\n" ~ programName ~ ` [options] Dir1 Dir2 ...` ~
`
Options:
-s : treat equality by size (default)
-n : -//- by name
`);
}

struct FileInfo
{
	string name;
	string fullName;
	ulong size;
}