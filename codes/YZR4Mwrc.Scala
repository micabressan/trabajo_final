val mat = Matrix(3, 3, Array(
    e"1", e"2", e"1",
    e"6", e"8", e"7",
    e"1", e"2", e"9"
  ))

  val vec = Vector(Array(
    e"1",  e"2" , e"3" ))

  println(solveLinearSystemSingular(mat, vec).simplifyAll().show)

//решает СЛАУ символьно (бесконечная точность)
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Vector(3)
(11 / (-8)) (17 / 16) (1 / 4) 

========================================================================
val mat = Matrix(3, 3, Array(
    e"1", e"2", e"1",
    e"6", e"8", e"7",
    e"1", e"2", e"9 + p" //СМОТРИ Тут ПАРАМЕТР "p"
  ))

  val vec = Vector(Array(
    e"1",  e"2" , e"3" ))

  println(solveLinearSystemSingular(mat, vec).simplifyAll().show)
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Vector(3)
(1 + (((-2) * (((2 / (8 + p)) * (1 / 4)) + 1)) + ((2 / (8 + p)) * (-1)))) (((2 / (8 + p)) * (1 / 4)) + 1) (2 / (8 + p))