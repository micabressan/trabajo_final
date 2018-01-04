/*
 * dmd test10.d -m32
 * test10.d(25): Error: cannot implicitly convert expression (argString) of type const(char)[] to shared(shared(const(char))[])
 */
private import std.stdio;

class Foobar
{
    shared int sharedNumber;
    shared const(char)[] sharedString;

    synchronized int getNumber() shared {
        return sharedNumber;
    }

    synchronized void setNumber(int argNumber) shared {
        sharedNumber = argNumber;
    }

    synchronized void setString(const(char)[] argString) shared {
        sharedString = argString;
    }

    synchronized string getString() shared {
        return sharedString.idup;
    }
}

int main() {
  shared(Foobar) foobar = new shared(Foobar)();

  foobar.setNumber(1);
  writefln("%d", foobar.getNumber());

  foobar.setString("hello world!");
  writefln("%s", foobar.getString());

  return 0;
}