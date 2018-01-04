case class F(n: Double) {
  def toC: C =
    C((n - 32) / 1.8)
}

case class C(n: Double) {
  def toF: F =
    F((n * 1.8) + 32)
}

C(0).toF
F(450).toC 

/*
res0: F = F(32.0)
res1: C = C(232.22222222222223)
 */