def assertEquals(message:String, a:Any, b:Any)
     = assert(a == b, message + " [ " + a + " != " + b + " ] ")
def assertEquals(a:Any, b:Any)                 
     = assertEquals("", a, b)


====================================
Main.scala:7: error: overloaded method assertEquals needs result type
        def assertEquals(a:Any, b:Any)                 = assertEquals("", a, b)







While:
===================================

def assertEquals(message:String, a:Any, b:Any)
     = assert(a == b, message + " [ " + a + " != " + b + " ] ")
def assertEquals(a:Any, b:Any):Unit //<-- Added Unit here
     = assertEquals("", a, b) 

====================================
Compiled successfully