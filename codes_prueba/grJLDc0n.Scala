//==================================================
// 22c22 Fall 2011
//
// Homework 2, Part B
//
// Name: Andy Butler
//
//==================================================

/* The default constructor of Polynomial is private.
   It can only be called by the auxiliary constructors
   defined in the class
*/
class Polynomial private (
  private val l: List[(Int,String)], 
  private val c:Int
  )  {
 
  /* This constructor allows the creation of constant polynomials:
       new Polynomial(n)  returns the constant polynomial n
  */
  def this(n:Int) = this(Nil,n)
  
  /* This constructor allows the creation of monomials:
       new Polynomial(n,x)  
     returns the monomial n*x if n is non-zero.
     if n is zero, it has the same effect as   new Polynomial(n)
  */
  def this(n:Int, x:String) = this(if (n==0) Nil else List((n,x)), 0)
  
  /* isZero returns true iff the polynomial is the constant polynomial 0
  */
  def isZero:Boolean = (l == Nil && c == 0) 
 
  
  /* In general, toString converts a polynomial with constant value c,
     unknowns x_1,,..., x_n and respective (non-zero) coefficients
     c_1,...,c_n into a string of the form
     
           c_1*x_1 + c_2*x_2 + ... + c_n*x_n + c
           
     with no spaces around * and 1 space character before and after +.
     
     Exceptions:
     -- if the coefficient of c_i is 1, then x_2 is used instead of 1*x_2
     -- if c is 0 and n > 0, the returned string is
          c_1*x_1 + c_2*x_2 + ... + c_n*x_n
     -- if n = 0, the returned string is just c
     
     The unknowns must be listed in alphabetical order.
     Example: 3*y + 2*x + 1 is not allowed, it must be 2*x + 3*y + 1

 */
 override def toString:String = {
	var a = l.sort((e1, e2) => (e1._2 compareTo e2._2) < 0)
	var i = 0;
	var s = "";
	while(i < a.size - 1) {
		if(a(i)._1 == 1) s += a(i)._2 + " + ";
		else if(a(i)._1 != 0) s += a(i)._1 + "*" + a(i)._2 + " + ";
	}
	if(i < a.size) {
		if(a(i)._1 == 1) s += a(i)._2;
		else if(a(i)._1 != 0) s += a(i)._1 + "*" + a(i)._2;
		i+=1;
	}
	if(i == 0) s += c;
	else if(c != 0) s += " + " + c;
	return s;
  }

  /* +(p) returns a new polynomial that is the result of adding 
     the current polynomial and p 
  */
  def +(that:Polynomial):Polynomial = {
		var i = 0;
		var l2:List[(Int, String)] = List[(Int, String)]();
		while(i < l.size) {
			var j = 0;
			var flag = true;
			while(j < that.l.size) {
				if(l(i)._2 == that.l(j)._2) {
					//l2 = l2 + ((l(i)._1 + that.l(j)._1, l(i)._2));
					l2 = List[(Int, String)]((l(i)._1 + that.l(j)._1, l(i)._2)):::l2;
					flag = false;
				}
				j+=1;
			}
			if(flag) l2 = List[(Int, String)](l(i)):::l2;
			i+=1;
		}
		var k = 0;
		while(k < that.l.size) {
			var m = 0;
			var flag = true;
			while(m < l2.size) {
				if(l2(m)._2 == that.l(k)._2) flag = false;
				m+=1;
			}
			if(flag) l2 = List[(Int, String)](that.l(k)):::l2;
			k+=1;
		}
		var poly = new Polynomial(l2, that.c + c); 
		//print(poly.l + " " + poly.c);
		return poly;	//there's something wonky going on here. I can't find what it is, but I can't apparently return a Polynomial with more than one
		//print(l2);	//(Int, String) tuple. (below example doesn't work) But creating it then printing it out works, and then the return stalls.
		//return new Polynomial(List[(Int, String)](  (2, "x"), (3, "y")  ), c + that.c);
	}											
 
  
  /* *(k) returns a new polynomial that is the result of multiplying 
     the current polynomial by k 
  */
  def *(k:Int):Polynomial = {
	var l2 = List[(Int, String)]();
	var i = 0;
	while(i < l.size) {
		l2 = (l(i)._1 * k, l(i)._2)::l2;
		i+=1;
	}
	return new Polynomial(l2, c * k);
  }
  
    
  /* pEquals(p) returns true iff the current polymomial and p are 
     equal as polynomials (although they might be distinct objects).
  */
  private def pEquals(that:Polynomial):Boolean = {
	if(c != that.c) return false;
	var a = l.sort((e1, e2) => (e1._2 compareTo e2._2) < 0)
	var a2 = that.l.sort((e1, e2) => (e1._2 compareTo e2._2) < 0)
	if(a.size != a2.size) return false;
	var i = 0;
	while(i < a.size) {
		if(a(i)._1 != a2(i)._1) return false;
		if(a(i)._2 != a2(i)._2) return false;
		i+=1;
	}
	return true;
   }
 
  
  /* the following overrides the default definition of == (an alias of equals)
     in terms of your pEquals
  */
  override def equals(o:Any) = o match {
      // if o is an instance of Polynomial then ask pEquals
      case x:Polynomial => pEquals(x)
      // otherwise return false
      case _ => false
  }

  def printme() = {
    println(l + " " + c);
  }
}

object Main {
    def main(args: Array[String]) {
	var p:Polynomial = new Polynomial(5, "x");
	var q:Polynomial = new Polynomial(7, "z");
	var r:Polynomial = new Polynomial(12, "z");
	var z:Polynomial = p + q + r;
	z.printme();
    }
}


//	List((5,x), (19,z)) 0