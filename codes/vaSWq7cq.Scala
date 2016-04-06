object Experiment {

  type Foo = Int

  case class FooPlusPlus(f: Foo)

  object Foo {
    implicit def toFooPlusPlus(f: Foo): FooPlusPlus = FooPlusPlus(f)
  }

  def bar(fpp: FooPlusPlus) = fpp.toString

  val f: Foo = 2

  bar(f)

}


/** type mismatch; found : Foo, (which expands to) Int, required: FooPlusPlus, bar(f) */