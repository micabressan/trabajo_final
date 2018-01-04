module sql.reader;

import etc.c.sqlite3;
import std.typecons;
import std.string : toStringz, fromStringz;

class Reader
{
	this(string dbFile)
	{
		int rc;
		
		rc = sqlite3_open(toStringz(dbFile), &db);
		if(rc != SQLITE_OK) throw new Exception("Could not open database to read: " ~ dbFile);
	}
	
	~this()
	{
		if(db) close();
	}
	
	void close()
	{
		sqlite3_close(db);
	}
	
	private sqlite3* db;
	
	R[] readFullTable(R)(string tableName, int max)
	if(isTuple!R)
	{
		auto rows = new R[5];
		return rows;
	}
}