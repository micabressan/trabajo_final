class Employee(private var _surname: String) {
  private var _fired: Boolean = false;
  
  Employee.increaseCounter();
  
  def surname = _surname;
  
  def surname_ (newSurname: String) = {
    _surname = newSurname;
  }
  
  def fired() = _fired;
  
  def fire() = {
    _fired = true;
    
    Employee.reduceCounter();
  }
  
  override def toString() : String = {
    var result = surname;
    
    if (fired()) {
      result = result + " (zwolniony)";
    }
    
    result;
  }
}

object Employee {
  private var _employeesAmount: Int = 0;
  
  private def increaseCounter() = {
    _employeesAmount = employeesAmount + 1;
  }
  
  private def reduceCounter() = {
    _employeesAmount = employeesAmount - 1;
  }
  
  def employeesAmount = _employeesAmount;
}

var hop = new Employee("Lorem");
var siup = new Employee("Ipsum");
println(Employee.employeesAmount);

hop.fire();


println(hop);
println(Employee.employeesAmount);