trait Debug {
 def debugVars() = for ( x <- getClass.getDeclaredFields ) {
  x.setAccessible(true);
  println(x.getName + " = " + "(" + x.getType.toString + ") " + x.get(this).toString);
 }
}