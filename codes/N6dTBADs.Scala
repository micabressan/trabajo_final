import scala.annotation.tailrec
import scala.math.abs
import scala.math.Fractional.Implicits._

package object math {

  /**
   * Tail-recursive _k_-nearest-neighbor search.
   *
   * This implementation uses a distance function with the signature
   * `(T) => Comparable`  to compute the distance from the target to the element
   * in question. There are helper  functions which will provide this distance
   * function automatically if you want to  do _k_-nearest-neighbor search over
   * a set of `Int`s, `Float`s, `Long`s or `Double`s, which accept a target as a
   * parameter and construct a distance function using the absolute value of the
   * difference between the element and the target. If you want to perform
   * _k_-nearest searches across sets of other types, you'll have to roll your
   * own distance function. While this seems like a pain, it also means that
   * this search  algorithm should be applicable to pretty much anything - you
   * can do nearest-neighbor  searches across `List`s or `String`s or bitmaps or
   * literally any other thing you can write a distance function for.
   *
   * This tail-recursive implementation should be approximately the most
   * performant  possible algorithm for performing _k_-nearest search without
   * preprocessing the inputs.
   *
   * @param k the number of nearest neighbors
   * @param xs a `Set` of `T` from which to find the nearest neighbors
   * @param dist the distance function
   * @tparam A the type of the item being searched
   * @tparam B the type of the distance result
   * @return a set containing the nearest _k_ values
   */
  def kNearest[A,B : Ordering](k: Int, xs: Set[A])(dist: (A) ⇒ B): Set[A]
    = { require(k > 0, "Values of k must be greater than zero")
        @tailrec def findKNearest(k: Int, xs: Set[A], neighbors: Set[A]): Set[A]
          = { val nearest = xs minBy dist
              k match {
                case 0 ⇒ neighbors + nearest
                case _ ⇒ findKNearest(k - 1, xs - nearest, neighbors + nearest)
              }
            }
        findKNearest(k, xs, Set())
      }

  /**
   * Distance function for two `A`s such that `A : `[[Numeric]].
   * @param  a the first of the two numbers to compare
   * @param  b the second of the two numbers to compare
   * @return the distance between `a` and `b` as a positive number
   */
  def numericDistance[A : Numeric](a: A, b: A): A
    = implicitly[Numeric[A]].abs(implicitly[Numeric[A]].minus(a, b))

  def kNearest[A : Numeric](k: Int, target: A, xs: Set[A]): Set[A]
    = kNearest[A,A](k,xs)((it: A) ⇒ numericDistance(it, target))

  def normalizeAt[A : Fractional](at: A)(xs: Seq[A]): Seq[A]
    = { val sigma = (xs sum ) * at
        xs map ( x ⇒  x / sigma )
      }

}