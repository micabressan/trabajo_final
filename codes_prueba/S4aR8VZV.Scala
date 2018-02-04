/**
The following code was created on the basis of Michid's Weblog https://michid.wordpress.com/2009/02/23/function_mem/
and influenced by Daniel Spiewak's comment.

From what I understand, because of this implementation of Memoization, tail recursion compilation cannot be applied.
As a result it is possible to have a StackOverflowError (try: fibonacci(250000)).  This can be avoided if the calculations are performed from the base cases up, instead of final case down to the base cases.

A bad solution to this that I can think of would be to check if the value is over a certain size (say 1000) and then calculate up from there. Below is a bad implementation of this idea.

Hugh Kaznowski
*/
object Solution {

  class Memoize[-I, +O](f: (I, I=>O) => O) {
    private[this] val cache = scala.collection.mutable.Map[I, O]();
    def apply(i: I): O = {
      if (cache.contains(i))
        cache(i)
      else {
        println(s"Calculating for $i")
        val ret = f(i, apply)
        cache.put(i, ret)
        ret
      }
    }
  }

  def fib(v: Int, f: (Int=>Int)): Int = {
    if (v<3)
      1
    else
      f(v-2)+f(v-1)
  }

  def badfib(v: Int, f: (Int=>Int)): Int = { // Can definitely be optimized
    if (v>1000)
      Range(v/2, v-2).foreach(f(_))
    if (v<3)
      1
    else
      f(v-2)+f(v-1)
  }

  def main(args: Array[String]): Unit = {
    val fibonacci = new Memoize(fib)
    val bfibonacci = new Memoize(badfib)

    bfibonacci(2500000) // This will take a long time
    println("-------------")
    bfibonacci(26)
  }
}