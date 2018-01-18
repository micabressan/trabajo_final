def doIt(Type1 arg1, Type2 arg2)
  if (arg1 is not null and arg1 is not null):
    # do something to both args
  else (if arg1 is not null):
    # do something to arg1 only
  else (if arg2 is not null):
    # do something to arg2 only
  else:
    # default action

def doIt(Type1:arg1):
  # do something to arg1

def doIt(Type2:arg2):
  # do something to arg2

def doIt(Type1:arg1, Type2:arg2)
  # do something to both args

def doIt():
  # do something here

#this is the caller
def caller1():
  val val1 = call_something_that_might_return_a_null_Type1()
  val val2 = call_something_that_might_return_a_null_Type2()
   
  doIt(val1, val2)

def caller2():
  val val1 = call_something_that_might_return_a_null_Type1()
  val val2 = call_something_that_might_return_a_null_Type2()

  if (val1 is not null and val2 is not null):
    doIt(val1, val2)
  else if (val1 is not null):
    doIt(val1) 
  else if (val2 is not null):
    doIt(val2)
  else:
    doIt();