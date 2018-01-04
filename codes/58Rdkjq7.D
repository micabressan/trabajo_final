/*

 * dmd test10.d -m32

 * 

 * test10.d(14): Error: function test10.Foobar.set (int number) shared is not callable using argument types (int)

 */

class Foobar

{

    shared private int number = 0;

    synchronized int set(int number)

    {

        return this.number = number;

    }

};



int main()

{

    Foobar foobar = new Foobar();

    

    return foobar.set(12);

}