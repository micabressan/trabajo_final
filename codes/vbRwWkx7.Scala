import shapeless._

case class Employee(name: String, number: Int, manager: Boolean)
case class IceCream(name: String, numCherries: Int, inCone: Boolean)

def genericCsv(gen: String :: Int :: Boolean :: HNil) =
  List(gen(0), gen(1).toString, gen(2).toString)

genericCsv(Generic[Employee].to(Employee("Dave", 123, false)))

genericCsv(Generic[IceCream].to(IceCream("Sundae", 1, false)))

/*
res0: List[String] = List(Dave, 123, false)

res1: List[String] = List(Sundae, 1, false)
 */