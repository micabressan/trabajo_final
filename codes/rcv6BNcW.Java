fun main(args: Array<String>) {
    val number1 = 0
    val number2 = 100
    
   outloop@ for (i in number1.. number2) {
        if (i == 1 || i == 0) continue
        for (num in 2..Math.sqrt(i.toDouble()).toInt()) {
            if (i % num == 0) {
                continue@outloop
            }
    	}
        println("$i is a prime number")
    }
}