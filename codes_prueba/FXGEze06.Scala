  def find(a:A):Option[Graph[A]] = {
    val seen:mutable.Set[A] = mutable.Set()
    def innerFind(ns:Seq[Graph[A]]):Option[Graph[A]] = {
      for (n <- ns) {
        if (!seen(n.v)) {
          seen += n.v
          if (n.v == a) {
            return Some(n)
          }
          innerFind(n.ns) match {
            case p@Some(_) => return p
            case None => ()
          }
        }
      }
      None
    }
    if (a == v) {
      return Some(this)
    }
    innerFind(ns)
  }