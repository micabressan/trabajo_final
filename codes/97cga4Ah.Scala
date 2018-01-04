class Foo
case class Bar(a: Int) extends Foo
case class Baz(a: String) extends Foo
case class Qux(a: Long) extends Foo

//Function takes a set of conditions, checks to see if those conditions are true, and does work
//on them if they are.
def doSomethingInAParticularCase(test: PartialFunction[Foo, Boolean], value: Foo) = {
  if(test.isDefinedAt(value) && test(value))
    println("Working on " + value)
}

def testMethod1(a: Int) = {
  println("Lalalala.  I'm doing a lot of work.")
  true
}

def testMethod2(a: Long) = {
  println("Lalalala.  I'm doing a lot of work.")
  true
}

//This is ideally the only type of condition PF I want to allow
val goodCondition : PartialFunction[Foo, Boolean] = {
  case Bar(a) if testMethod1(a) => true
  case Qux(a) if testMethod2(a) => true
}

doSomethingInAParticularCase(goodCondition, Bar(1))  //Does "a lot of work" twice.
doSomethingInAParticularCase(goodCondition, Qux(1))  //Does "a lot of work" twice.
doSomethingInAParticularCase(goodCondition, Baz("Foo"))  //Doesn't do much work at all.

//However, some dev could do this.
val badCondition : PartialFunction[Foo, Boolean] = {
  case Bar(a) if testMethod1(a) => false
  case Qux(a) if testMethod2(a) => true
}

doSomethingInAParticularCase(badCondition, Bar(1))  //Does "a lot of work" twice, but then never does anything.  Lots of wasted work.
doSomethingInAParticularCase(badCondition, Qux(1))  //Does "a lot of work" twice.
doSomethingInAParticularCase(badCondition, Baz("Foo"))  //Doesn't do much work at all.

/*
Ideally, the places where it we do "a lot of work" could be optimized such that they only do it once by seeing if the value is defined at the condition PF and then if it is, doing work on it.  However, because a dev could theoretically write something like badCondition, I'd have to ensure that the condition actually does evaluate to true at a given value, thus forcing me to evaluate it twice.  If I could make the condition PF of type PartialFunction[Foo, True], then a dev couldn't write that bad condition and I could change doSomethingInAParticularCase to:
def doSomethingInAParticularCase(test: PartialFunction[Foo, Boolean], value: Foo) = {
  if(test.isDefinedAt(value))
    println("Working on " + value)
}
and this would reduce the amount of work we do.  Yay.
*/