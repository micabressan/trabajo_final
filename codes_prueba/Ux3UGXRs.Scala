  import scala.util.continuations.cpsParam  //@cpsParam[Unit,Unit] is equivalent to @suspendable

  def subFunc() : Unit@cpsParam[Unit,Unit] = {}

  //Compilation fail on funcA, the error message is :
  //  Error:(13, 6) type mismatch;
  //  found   : Unit
  //  required: Unit @scala.util.continuations.cpsParam[Unit,Unit]
  //    if(cond){
  def funcA(cond : Boolean) : Unit@cpsParam[Unit,Unit] = {
    if(cond){  //This is where the error is pointing
      subFunc()
    }
    subFunc()
  }

  //Compilation OK
  def funcB(cond : Boolean) : Unit@cpsParam[Unit,Unit] = {
    val dummy = if(cond){
      subFunc()
    }
  }


  //Compilation OK
  def funcC(cond : Boolean) : Unit@cpsParam[Unit,Unit] = {
    val dummy = if(cond){
      subFunc()
    }
    subFunc()
  }

  //Compilation OK
  def funcD(cond : Boolean) : Unit@cpsParam[Unit,Unit] = {
    if(cond){
      subFunc()
    } else {
      subFunc()
    }
  }

  //Compilation OK
  def funcE(cond : Boolean) : Unit@cpsParam[Unit,Unit] = {
    if(cond){  //This is where the error is pointing
      ???
    }
    subFunc()
  }