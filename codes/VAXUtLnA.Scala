  def deposit(): Unit = {
    var number = 0
    var amount = 0
    
    try {
      BankApplication.console("Account number to deposit to:")
      number = scala.io.StdIn.readInt()
      
      BankApplication.console("Insert amount you want to deposit:")
      amount = scala.io.StdIn.readInt()
      BankApplication.console(BankApplication.getCurrentBank().doEvent(Deposit(number, amount)))
    } catch {
      case _: NumberFormatException => BankApplication.console("Wrong format!!")
      case e: Exception => throw e
    }
  }
  
  def withdraw(): Unit = {
    var number = 0
    var account: BankAccount = null
    var amount = 0
    
    try {
      BankApplication.console("Account number to withdraw from:")
      number = scala.io.StdIn.readInt()
      
      BankApplication.console("Insert amount you want to withdraw:")
      amount = scala.io.StdIn.readInt()
      
      if(amount < 0) {
        throw new NumberFormatException
      }
      BankApplication.console(BankApplication.getCurrentBank().doEvent(Withdraw(number, amount)))
    } catch {
      case _: NumberFormatException => BankApplication.console("Wrong format!")
      case e: Exception => throw e
    }
  }
  
  def transfer(): Unit = {
    var numberFrom = 0
    var numberTo = 0
    
    var amount = 0
    
    try {
      BankApplication.console("Account number to withdraw from:")
      numberFrom = scala.io.StdIn.readInt()
      BankApplication.console("Account number to deposit to:")
      numberTo = scala.io.StdIn.readInt()
      BankApplication.console("Insert amount you want to transfer:")
      amount = scala.io.StdIn.readInt()
      
      if(amount < 0) {
        throw new NumberFormatException
      }
      BankApplication.console(BankApplication.getCurrentBank().doEvent(Transfer(numberFrom, numberTo, amount)))
    } catch {
      case _: NumberFormatException => BankApplication.console("Wrong format!!")
      case e: Exception => throw e
    }
  }
  
  def create(): Unit = {
    BankApplication.console("Please specify the name of the account holder:")
    val name = scala.io.StdIn.readLine()
    BankApplication.console(BankApplication.getCurrentBank().doEvent(NewAccount(generalHelper.generateNewID(), name)))
  }
  
  def delete(): Unit = {
    BankApplication.console("Please specify the accountnumber of the account you want to delete:")
    try{
      val accNbr = scala.io.StdIn.readInt()
      BankApplication.console(BankApplication.getCurrentBank().doEvent(DeleteAccount(accNbr)))
    } catch {
      case _: NumberFormatException => BankApplication.console("Unknown format!")
    }
  }