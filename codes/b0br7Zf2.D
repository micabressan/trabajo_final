import std.stdio;
import std.file;

struct rtInfo
{
    import core.sys.posix.sys.types, core.sys.posix.unistd;

    static uid_t uid;
    static gid_t gid;

    static this()
    {
        uid = geteuid();
        gid = getegid();
    }
}

bool isReadable(DirEntry ent)
{
    import core.sys.posix.sys.stat;

    auto s = ent.statBuf;
    
    return rtInfo.uid == s.st_uid && s.st_mode & S_IRUSR
        || rtInfo.gid == s.st_gid && s.st_mode & S_IRGRP
        || s.st_mode & S_IROTH;
}

bool isReadable(string path)
{
    return isReadable( DirEntry(path) );
}

void scan(string dir)
{
    if ( !isReadable(dir) ) return;

    foreach (ent; dirEntries(dir, SpanMode.shallow))
    {
        writeln(ent.name);

        if (ent.isDir && ent.isReadable) 
        {
            scan(ent.name);
        }
    }
}

int main(string[] args)
{
    string dir = args.length > 1 ? args[1] : ".";

    scan(dir);

    return 0;
}