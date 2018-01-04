def set(elem: Int): Set = {
  def f(x: Int): Boolean = {
    if (x == elem) true
    else false
  }
  f
}

// Équivalent, mais avec une "fonction anonyme" (c'est à dire sans nom)
def set(elem: Int): Set = {
  (x => if (x == elem) true else false)
}