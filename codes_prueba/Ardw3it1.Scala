def doIt(Type1 arg1, Type2 arg2)
  if (arg1 is not null and arg1 is not null):
    # do something to both args
  else (if arg1 is not null):
    # do something to arg1 only
  else (if arg2 is not null):
    # do something to arg2 only
  else:
    # exception here at least one argument must be provided

fun doIt(Type1 arg1):
  # do something to arg1

fun doIt(Type2 arg2):
  # do something to arg2

fun doIt(Type1 arg1, Type2 arg2)
  # do something to both args

#this is the caller
fun caller():
   Type1 val1 = call something that might return null
   Type2 val2 = call something that might return null
   ...