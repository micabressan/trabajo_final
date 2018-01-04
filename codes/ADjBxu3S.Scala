  def contains(a:A):Boolean = {
    val seen:mutable.Set[A] = mutable.Set()
    def innerContains(ns:Seq[Graph[A]]): Boolean = {
      for (n <- ns) {
        if (!seen(n.v)) {
          seen += n.v
          if (n.v == a) {
            return true
          }
          innerContains(n.ns)
        }
      }
      false
    }
    v == a || innerContains(ns)
  }