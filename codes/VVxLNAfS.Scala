object MyApp extends App {

  val x = 1 to 10
  val b = x.filter(e => e > 2)

  b foreach println

}