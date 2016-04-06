class Rec (frw: Actor) extends Actor 
{
	val myList = Nil;
	def act = 
	{
		case "Start" => while(true) {//Extract the first number and send it to frw} //I must use a new actor if I want to keep reading messages
		case i => myList+=i; //Should i use a "synchronize" here (i'm extracting elements with the other actor after all) 
	}
}

class Sen (rcv: Actor) extends Actor 
{
	var i=100;
	def act = 
	{
		case "Start" => while(i>0) {i+=1; rcv ! i;}
	}
}