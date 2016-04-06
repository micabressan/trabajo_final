def jsDebug(code: String): Boolean = {
    val pairs: Map[Char,Char] = Map(
        '}' -> '{',
        ']' -> '[',
        ')' -> '('
    )
    def go(code: String, index: Int, acc: Boolean, acc_list: List[(Char, Boolean)]): Boolean = { 
        //println(code,index,acc,acc_list)
        if (index == code.length) { 
            acc && acc_list.unzip._2.foldLeft(true)((a,b) => a && b)
        } else {
            val (chars,nestings) = acc_list.unzip
            if (pairs.values.toSet contains code(index)) {
                go(code,index+1,acc,acc_list ++ List((code(index),false)))
            } else {
                if (pairs.keys.toSet contains code(index)) {
                    val order = chars.reverse
                    val norder = nestings.reverse
                    val aorder = acc_list.reverse
                    val o_index = aorder.indexWhere {
                        case (a,b) => a == pairs(code(index)) && b == false
                    }
                    if (o_index != -1) {
                        val o_subset = norder.slice(0,o_index)
                        val new_acc_list = (aorder.slice(0,o_index) ++ List((order(o_index), true)) ++ aorder.slice(o_index+1,aorder.length)).reverse
                        if (o_subset.foldLeft(true)((a,b) => a && b)) {
                            go(code,index+1,acc,new_acc_list)                                
                        } else {
                            go(code,index+1,false,new_acc_list)
                        }
                    } else {
                        go(code,index+1,false,acc_list)
                    }
                } else {
                    go(code,index+1,acc,acc_list)
                }
            }
        }
    }
    go(code,0,true,List())
}


println(jsDebug("{[]()}")) //true
println(jsDebug("{[(])}")) //false
println(jsDebug("{[}")) //false