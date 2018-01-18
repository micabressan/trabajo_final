// excercise 3

class EmptyException(msg: String) extends Exception(msg)
class CMyQueue[+T] private (private val queue: (List[T],List[T]))
{  
  private def helper[S>:T](xs: List[S], ys: List[S]) = xs match
      {
        case Nil => (ys.reverse, Nil)
        case _ => (xs, ys)
      }
  
  def enqueue[S>:T](x: S): CMyQueue[S] = new CMyQueue(helper(queue._1, x::queue._2))
  def dequeue() = queue match
  {
    case (h::t, ys) => new CMyQueue(helper(t, ys))
    case (Nil, _) => new CMyQueue(Nil, Nil)
  }
  def first() = queue._1 match
  {
    case x::_ => x
    case Nil => throw new EmptyException("Empty queue - first")
  }
  def isEmpty() = queue._1 == Nil
} // class CMyQueue[+T] private (private val lists: (List[T],List[T]))

object CMyQueue
{
  def apply[T](xs: T*) = new CMyQueue[T](xs.toList, Nil)
  def empty[T]() = new CMyQueue[T](Nil, Nil)
} // object CMyQueue

class Parents(name: String = "Wladzia i Arek")
{
  override def toString = name
}

class Child(name: String = "Ola", male: String = "female") extends Parents(name)
{
  override def toString = super.toString + ", male: " + male 
}

val p1 = new Parents
val c1 = new Child
val que1 = CMyQueue(new Child("Kasia"), new Child("Wojtek"), new Child("Krzysiek"))

que1.enqueue(c1)
que1.first()
que1.enqueue(p1)
que1.first()
que1.enqueue(c1).enqueue(p1).dequeue().dequeue().dequeue().first().asInstanceOf[Child]

// excercise 4

import scala.collection.mutable.Seq

def copy[T](dest: Seq[T], src: Seq[T])  = 
{
  require(dest.length >= src.length)
  var ii = 0
  src.foreach(elem => 
  { 
    dest.update(ii,elem)
    ii = ii + 1
  })
}

val src = Seq(new Child, new Child("Kasia"))
val dest = Seq(new Child("Krzysiek"), new Child("Wojtek"), new Child("Krzysiek"))
dest.foreach(ele => {println(ele)})
copy(dest, src)
dest.foreach{println}