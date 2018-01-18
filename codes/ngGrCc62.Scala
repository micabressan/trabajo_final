class DualListQueue[+T] private (private val frontList: List[T],
                        private val rearList: List[T]) {
  def enqueue[S >: T] (element: S): DualListQueue[S] = {
    (frontList, rearList) match {
      case (Nil, Nil) => new DualListQueue[S](List(element), List())
      case(front, rear) => new DualListQueue[S](front, element::rear)
    }
  }

  def dequeue(): DualListQueue[T] = {
    (frontList, rearList) match {
      case (_::Nil, rear) => new DualListQueue[T](rear.reverse, Nil)
      case(_::t, rear) => new DualListQueue[T](t, rear)
      case(Nil, Nil) => this/*new DualListQueue[T](Nil, Nil)*/ //TODO: check
    }
  }

  def first(): T = {
    (frontList, rearList) match {
      case (h1::_, _) => h1
      case(Nil, Nil) => throw new Exception("Underflow exception")
    }
  }

  def isEmpty(): Boolean = {
    (frontList, rearList) == (Nil, Nil)
  }
}

object DualListQueue {
  def apply[T](xs: T*) = new DualListQueue[T](xs.toList, List[T]())
  def empty[T] = new DualListQueue[T](Nil, Nil)
}