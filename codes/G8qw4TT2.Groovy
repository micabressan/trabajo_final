public Date resurrectionDay(int daysDead) {
    String theDate = "03/30/2018 15:02:43";
    def goodFriday = new Date().parse("MM/dd/yyyy H:m:s", theDate);
    return goodFriday + daysDead
}
 
/**
 * The following line passes the value 3 to the function resurrectionDay() like so, "resurrectionDay(3)"
 * to add  3 days to Friday's date.
 */
println "If Jesus were crucified in 2018 on \"Good Friday\" he would rise in 3 days on ${resurrectionDay(3)}"
 
/**
 * The following line passes the value 2 as a parameter to the function resurrectionDay() to end on !Easter Sunday"
 */
println "When you observe both \"Easter Sunday\" and \"Good Friday\" you only add two days ${resurrectionDay(2)}"