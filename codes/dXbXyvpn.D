private import tango.io.Stdout;

class Foobar
{
    private int number = 0;

    synchronized int get()
    {
            return this.number;
    }

    synchronized set(int number)
    {
        this.number = number;
    }
};

int main()
{
    Foobar foobar = new Foobar();

    foobar.set(1);
    Stdout(foobar.get()).newline;

    return 0;
}