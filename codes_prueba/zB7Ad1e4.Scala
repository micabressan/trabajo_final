package p06sandbox

import breeze.linalg._

import p04various.TypeDef._

object TypeErasure {
  trait DenseContent[T] {
    def compute(v: DenseVector[T]): String
  }

  object DenseContent {
    implicit object _Real extends DenseContent[Real] {
      def compute(v: DenseVector[Real]) = "real"
    }
    implicit object _Int extends DenseContent[Int] {
      def compute(v: DenseVector[Int]) = "int"
    }
    // etc ...
  }

  def print2[T : DenseContent](data: DenseVector[T]) = println(
     implicitly[DenseContent[T]].compute(data)
  )
  
  def main = {
    val v0 = DenseVector(1.2, 1.5, 1.6)
    val v1 = DenseVector(3, 4, 5)
    val a = Array(v0, v1)
    a.map(print2)
  }
}