import scala.collection.mutable
object CopyObject {
//  def copy[T](dest: mutable.Seq[T], src: mutable.Seq[T]): Unit = {
  def copy[S >: T, T, E <: T](dest: mutable.Seq[S], src: mutable.Seq[E]): Unit = {
    require(dest.size >= src.size)
    var i = 0
    src.foreach(elem => {
      dest.update(i, elem)
      i += 1
    })
  }
}