import java.util.Collections

object Main {

  val ranks = Array("Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King")

  val suits = Array("Spades","Clubs","Hearts","Diamonds")

  type Card = Int
  type Deck = List[Int]
  type Hand = (Int,Int)

  def main(args : Array[String]) : Unit = {
    val deck : Deck = (0 to 51).toList
    for(card <- deck){
      println(getRank(card).get ++ " of " ++ getSuit(card).get)
    }

    val result = dealHand(deck)
    val hand = result _2
    val newDeck = result _1

    println(getCardName(hand._1).get)
    println(getCardName(hand._2).get)
  }

  def getSuit(num : Card) : Option[String] = {
    if(num < 0 || num > 51) None
    Some (suits(Math.floorDiv(num,13)))
  }

  def getRank(num : Card) : Option[String] = {
    if(num < 0 || num > 51) None
    Some (ranks(num%13))
  }

  def dealHand(d : Deck) : (Deck,Hand) = {
    //Shuffles deck
    val newd = scala.util.Random.shuffle(d)
    val h : Hand = (newd.last,newd(newd.length-2))
    (newd.reverse.tail.tail,h)
  }

  def getCardName(card : Card) : Option[String] = {
    if(card < 0 || card > 51) None
    Some(getRank(card).get ++ " of " ++ getSuit(card).get)
  }

}