def chooseAgeBelowGiven(list : List[Person], age : Int)(implicit require : Ref["age > 0"]){
    list.filter(_.age < age)
  }

chooseAgeBelowGiven(List(Person("a", 10), Person("b", 18), Person("c", 20)), 18) //ok
chooseAgeBelowGiven(List(Person("a", 10), Person("b", 18), Person("c", 20)), -1) //runtime ошибка :
//assertion failed: Input constraint not kept: age > 0, on input: List(list = List(Person(a,10), Person(b,18), Person(c,20)), age = -1)