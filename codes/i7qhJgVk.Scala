package wwaldron.eggs.domain

import wwaldron.eggs.domain.Bacon.CookedBacon
import wwaldron.eggs.domain.Egg.CookedEgg
import wwaldron.eggs.domain.Waffle.CookedWaffle
import wwaldron.eggs.domain.WaffleStyle.Brussels

import scala.concurrent.{ExecutionContext, Future}

case class CookId(value: Integer) extends AnyVal

object Cook {
  case object OutOfEggsException extends IllegalStateException("There are no more eggs")
  case object OutOfBaconException extends IllegalStateException("There is no more bacon")
  case object OutOfWafflesException extends IllegalStateException("There are no more waffles")
}

class Cook(id: CookId)
          (eggRepository: EggRepository)
          (baconRepository: BaconRepository)
          (waffleRepository: WaffleRepository)
          (implicit ec: ExecutionContext) {
  import Cook._ //to get OutOfSomethingExceptions here
  private val fryingPan = EmptyFryingPan()

  private def waitEgg(pan: FullEggFryingPan): Unit = {
    while(!pan.checkDoneness())
      Thread.sleep(10)
  }

  private def waitBacon(pan: FullBaconFryingPan): Unit = {
    while(!pan.checkDoneness())
      Thread.sleep(10)
  }

  private def waitWaffle(pan: FullWaffleFryingPan): Unit = {
    while(!pan.checkDoneness())
      Thread.sleep(10)
  }

  def prepareEgg(style: EggStyle): Future[CookedEgg] = {
    eggRepository.findAndRemove().map { eggOption =>
      val egg = eggOption.getOrElse(throw OutOfEggsException)
      val fullFryingPan = fryingPan.add(egg, style)
      waitEgg(fullFryingPan)
      fullFryingPan.remove()._2
    }
  }

  def prepareBacon(style: BaconStyle): Future[CookedBacon] = {
    baconRepository.findAndRemove().map { baconOption =>
      val bacon = baconOption.getOrElse(throw OutOfBaconException)
      val fullFryingPan = fryingPan.add(bacon, style)
      waitBacon(fullFryingPan)
      fullFryingPan.remove()._2
    }
  }

  def prepareWaffle(style: WaffleStyle): Future[CookedWaffle] = {
    waffleRepository.findAndRemove().map { waffleOption =>
      val waffle = waffleOption.getOrElse(throw OutOfWafflesException)
      val fullFryingPan = fryingPan.add(waffle, style)
      waitWaffle(fullFryingPan)
      fullFryingPan.remove()._2
    }
  }


  def acceptListOfOrders(orders: List[Any]): Unit = {

    orders.foreach(println)

  }

  // Analogue to slide 49 and following.
  trait Orders {

    type Visitor[CookedX] <: CVisitor[CookedX]

    trait CVisitor[CookedX] {
      def visitOrder(o: Order) : Future[CookedX]
    }

    trait EvalVisitor extends CVisitor[CookedX] {}

    trait Order {
      def accept[CookedX](v: Visitor[CookedX]): Future[CookedX]
    }

    case class EggOrder(style: EggStyle) extends Order {
      def accept[CookedEgg](v: Visitor[CookedEgg]) : Future[CookedEgg] = v.visitOrder(this)
    }

    case class BaconOrder(style: BaconStyle) extends Order {
      def accept[CookedBacon](v: Visitor[CookedBacon]) : Future[CookedBacon] = v.visitOrder(this)
    }

    case class WaffleOrder(style: WaffleStyle) extends Order {
      def accept[CookedWaffle](v: Visitor[CookedWaffle]) : Future[CookedWaffle] = v.visitOrder(this)
    }
  }

  // Data extensions
  trait EggOrder extends Orders {
    type Visitor[CookedX] <: CVisitor[CookedX]

    trait CVisitor[CookedX] extends super.CVisitor[CookedX] {
      def visitEggOrder(egg: Egg, style: wwaldron.eggs.domain.EggStyle): Future[CookedX]
    }

    case class Egg(s: EggStyle) extends Order {
      def accept[CookedX](v: Visitor[CookedX]): Future[CookedX] = v.visitEggOrder(this, s)
    }

    trait EvalVisitor extends super.EvalVisitor with CVisitor[CookedX] {
      this: Visitor[CookedX] =>
      def visitEggOrder(e: Egg, style: wwaldron.eggs.domain.EggStyle): Future[CookedX] = {
        prepareEgg(style)
      }
    }
  }


  trait BaconOrder extends Orders {
    type Visitor[CookedX] <: CVisitor[CookedX]

    trait CVisitor[CookedX] extends super.CVisitor[CookedX] {
      def visitBaconOrder(b: Bacon, style: wwaldron.eggs.domain.BaconStyle) : Future[CookedX]
    }

    case class Bacon(b: BaconStyle) extends Order {
      def accept[CookedX](v: Visitor[CookedX]): Future[CookedX] = v.visitBaconOrder(this, b)
    }

    trait EvalVisitor extends super.EvalVisitor with CVisitor[CookedX] {
      this: Visitor[CookedX] =>
      def visitBaconOrder(b: Bacon, style: wwaldron.eggs.domain.BaconStyle) : Future[CookedX] = {
        prepareBacon(style)
      }
    }
  }


  trait WaffleOrder extends Orders {
    type Visitor[CookedX] <: CVisitor[CookedX]

    trait CVisitor[CookedX] extends super.CVisitor[CookedX] {
      def visitWaffleOrder(w: Waffle, style: wwaldron.eggs.domain.WaffleStyle): Future[CookedX]
    }

    case class Waffle(w: WaffleStyle) extends Order {
      def accept[CookedX](v: Visitor[CookedX]): Future[CookedX] = v.visitWaffleOrder(this, w)
    }

    trait EvalVisitor extends super.EvalVisitor with CVisitor[CookedX] {
      this: Visitor[CookedX] =>
      def visitWaffleOrder(w: Waffle, style: WaffleStyle): Future[CookedX] = {
        prepareWaffle(style)
      }
    }
  }


  //combining independent extensions
  trait AllOrders extends EggOrder with BaconOrder with WaffleOrder {
    type Visitor[CookedX] = CVisitor[CookedX]

    trait CVisitor[CookedX] extends super[EggOrder].CVisitor[CookedX] with super[BaconOrder].CVisitor[CookedX]
      with super[WaffleOrder].CVisitor[CookedX]

    object EvalVisitor extends super[EggOrder].EvalVisitor with super[BaconOrder].EvalVisitor with CVisitor[CookedX] {
      this: Visitor[CookedX] =>
    }
  }

  object AllExpressionsTest extends AllOrders with App {
    def o : Order = WaffleOrder(style = Brussels)
    Console.println(o.accept(EvalVisitor))
  }

}