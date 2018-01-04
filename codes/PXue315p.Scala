// always seal traits so you get exhaustive check
sealed trait Tree[+A]

// final so ppl cant fuck it up by extending your case class
final case class Node[A](left: Tree[A], value: A, right: Tree[A]) extends Tree[A]
// No need to have more than one of these, so can be object
// use nothing as type param
// renamed to Leaf as Nil is usually linked lists
case object Leaf extends Tree[Nothing]

object Tree {
  def node[A](v: A): Tree[A] = Node(Leaf, v, Leaf)

  def insert[A: Ordering](v: A, tree: Tree[A]): Tree[A] = tree match {
    case Leaf ⇒ node(v)
    case Node(left, value, right) if implicitly[Ordering[A]].lteq(v, value) ⇒ Node(insert(v, left), value, right)
    case Node(left, value, right) ⇒ Node(left, value, insert(v, right))
  }

  def traverse[A: Ordering, B: Ordering](f: (A ⇒ B), tree: Tree[A]): Tree[B] = tree match {
    case Leaf ⇒ Leaf
    case Node(left, value, right) ⇒ Node(traverse(f, left), f(value), traverse(f, right))
  }

  implicit val treeFunctor = new Functor[Tree] {
    def map[A, B](fa: Tree[A])(f: A => B): Tree[B] = fa match {
      case Leaf => Leaf
      case Node(left, v, right) => Node(map(left)(f), f(v), map(right)(f))
    }
  }
}

trait Functor[F[_]] {
  def map[A, B](fa: F[A])(f: A => B): F[B]
}