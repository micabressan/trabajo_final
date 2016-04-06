// WTF
def projEuler23 = {
  import scala.collection.mutable.Set
  def factors (x: Int) = Set(1) ++
    (2 to math.sqrt(x).toInt filter(x % _ == 0) flatMap(n => Stream(n, x / n)))
  def aux (abs: Array[Int], xs: Set[Int], a: Int, b: Int): Set[Int] = {
    xs -= (abs(a) + abs(b))
    if (b == abs.length - 1)
      if (a == abs.length - 1) xs
      else aux(abs, xs, a + 1, 0)
    else aux(abs, xs, a, b + 1)
  }

  val MAX = 28123
  val abundant = 1 until MAX filter(a => a < factors(a).sum) toArray
  val ans = aux(abundant, Set() ++ Stream.range(1, MAX + 1), 0, 0).sum
  ans
} 


// Sol
def properDivisors(n: Int) = (1 to n/2).filter(i => n % i == 0)

def isAbundant(n: Int) = properDivisors(n).sum > n

val abundantNumbers = (1 to 28123).filter(isAbundant)
val abundantMarkers = new Array[Boolean](28124)

// Update marker array true = # can be written as sum of 2 abundants
for (a <- abundantNumbers; b <- abundantNumbers if (a + b) < 28123) abundantMarkers(a + b) = true

val answer = (0 until 28123).filterNot(abundantMarkers).sum
println(answer)