class Foo extends Enumeration {
  type Foo = Value
  val A,B,C = Value
}
object Foo extends Foo

println(Foo.A)  //<Invalid enum: no field for #0>