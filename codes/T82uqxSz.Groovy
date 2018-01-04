def year = new Scanner(System.in).nextInt()
if (year>1918){
    def leap = (year % 400 == 0) || ((year % 4 == 0) && (year % 100))
    println (leap ? "12.09.$year" : "13.09.$year")
} else if (year<1918){
    def leap = (year % 4 == 0)
    println (leap ? "12.09.$year" : "13.09.$year")
} else {
    println ("26.09.1918")
}