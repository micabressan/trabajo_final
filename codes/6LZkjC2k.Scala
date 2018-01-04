scala> import scala.language.reflectiveCalls
import scala.language.reflectiveCalls

scala> def f(x:{val b:String}) = x.b
f: (x: AnyRef{val b: String})String

scala> f(new Object{val b="hi"})
res3: String = hi

scala> case class Foo(b:String)
defined class Foo

scala> f(Foo("qq"))
res4: String = qq