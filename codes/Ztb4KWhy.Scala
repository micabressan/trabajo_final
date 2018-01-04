import scala.annotation.tailrec

object ListDemo extends App {
  val listA = Nil
  val listB = new Cons(2, new Cons(4, Nil))

  println(listA)
  println(listB)
}

trait List[+T] {
  def isEmpty: Boolean
  def head: T
  def tail: List[T]
  def add[S >: T](element: S): List[S]
  def ++[S >: T](other: List[S]): List[S]
  def reverse: List[T]
}

object Nil extends List[Nothing] {
  override def isEmpty: Boolean = true

  override def head: Nothing = throw new NoSuchElementException

  override def tail: List[Nothing] = throw new UnsupportedOperationException

  override def add[S](element: S): List[S] = ???

  override def ++[S](other: List[S]): List[S] = other

  override def reverse: List[Nothing] = Nil

  override def toString: String = "[]"
}

class Cons[T](val head: T, val tail: List[T]) extends List[T] {
  override def isEmpty: Boolean = false

  override def add[S >: T](element: S): List[S] = new Cons(element, this)

  override def ++[S >: T](other: List[S]): List[S] = new Cons(head, tail ++ other)

  override def reverse: List[T] = {
    @tailrec
    def reverseUtil(input: List[T], output: List[T]): List[T] = {
      if (input.isEmpty) output
      else reverseUtil(input.tail, new Cons(input.head, output))
    }
    reverseUtil(this, Nil)
  }

  override def toString: String = {
    def enumerateAll(list: List[T]): String =
      if (list.isEmpty) ""
      else if (list.tail.isEmpty) "" + list.head
      else list.head + "  " + enumerateAll(list.tail)

    "[" + enumerateAll(this) + "]"

  }
}