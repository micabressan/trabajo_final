def max(x:Int, y:Int): Int ={ //fonction Max qui calcul le max de 2 entiers
if (x>y) x else y
}
________
def estMultiple(n:Int, p:Int):Boolean ={ // déterminer si n est multiple de p
n&p => 0 
}
________
def xor1(b1:Boolean, b2:Boolean):Boolean={ // 
if( b1==true&&b2==false) true else false
}

def xor1(b1:Boolean, b2:Boolean):Boolean={
b1 && !b2
}
_______
def signe(i: Int, s:String):Boolean={
s match {
  case "strictement positif" =>(i>0)
  case "strictement negatif" =>(i<0)
  case "null" =>(i==0)
}
}
println(signe(5,"strictement positif"))
println(signe(-8,"strictement negatif"))
println(signe(0,"null"))