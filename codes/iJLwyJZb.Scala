// List decomposition with pattern matching
// run time of isort is N*N ! not good
val xs = List(7, 3, 9, 2)

// worst case x is greater than all the elements of xs so time proportional to N
def insert(x: Int, xs: List[Int]): List[Int] = xs match {
  case Nil => x :: Nil
  case y :: ys => if(x <= y) x::xs else y::insert(x,ys)
}


// one call to insert for each element in the list so N*N quadratic!
def isort(xs: List[Int]): List[Int] = xs match {
  case Nil => Nil
  case y :: ys => insert(y, isort(ys))
}

val xsorted = isort(xs)

--------------- output -------------------

xs: List[Int] = List(7, 3, 9, 2)

insert: insert[](val x: Int,val xs: List[Int]) => List[Int]

isort: isort[](val xs: List[Int]) => List[Int]

xsorted: List[Int] = List(2, 3, 7, 9)