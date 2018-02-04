trait Debug {
  def debugName() : Unit = {
    print("Klasa: " + this.getClass.getName)
  }

  def debugVars() : Unit = {
    val fields = this.getClass.getDeclaredFields
    for(field <- fields){
      field.setAccessible(true)
      print("Pole: " + field.getName + " => " + field.getType.getName + ", " + field.get(this) + "\n")
    }
  }
}