def doIt(arg1:Type1, arg2:Type2)
  if (arg1 is not null and arg1 is not null):
    # do something to both args
  else (if arg1 is not null):
    # do something to arg1 only
  else (if arg2 is not null):
    # do something to arg2 only
  else:
    # default action

def caller():
  val val1 = call_something_that_might_return_a_null_Type1()
  val val2 = call_something_that_might_return_a_null_Type2()
   
  doIt(val1, val2)