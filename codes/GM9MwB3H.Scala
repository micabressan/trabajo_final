package quickcheck

import common._

import org.scalacheck._
import Arbitrary._
import Gen._
import Prop._

abstract class QuickCheckHeap extends Properties("Heap") with IntHeap {

  property("min1") = forAll { a: Int =>
    val h = insert(a, empty)
    findMin(h) == a
  }

  property("min2") = forAll { a: Int =>
    if (a == Integer.MAX_VALUE) {
      val h = insert(1, empty)
      val h2 = insert(2, h)
      findMin(h2) == 1
    } else {
      val h = insert(a + 1, empty)
      val h2 = insert(a, h)
      findMin(h2) == a
    }
  }

  property("min3") = forAll { a: Int =>
    val h = insert(a, empty)
    isEmpty(deleteMin(h))
  }

  property("gen1") = forAll { (h: H) =>
    val m = if (isEmpty(h)) 0 else findMin(h)
    findMin(insert(m, h)) == m
  }

  property("gen2") = forAll { (h1: H, h2: H) =>
    val merged = meld(h1, h2)
    if (isEmpty(h1) && isEmpty(h2)) {
      true
    } else if (isEmpty(h1)) {
      findMin(merged) == findMin(h2)
    } else if (isEmpty(h2)) {
      findMin(merged) == findMin(h1)
    } else {
      findMin(merged) == findMin(h1) || findMin(merged) == findMin(h2)
    }
  }

  property("gen3") = forAll { (h: H) =>
    def check(h: H): Boolean = {
      def checkAcc(h: H, last: Int): Boolean = {
        if (isEmpty(h)) true
        else if (findMin(h) < last) false
        else checkAcc(deleteMin(h), findMin(h))
      }
      if (!isEmpty(h)) checkAcc(deleteMin(h), findMin(h))
      else true
    }
    check(h)
  }

  property("gen4") = forAll { (list: List[Int]) =>
    def fillHeap(list: List[Int]): H = {
      def fillAcc(h: H, list: List[Int]): H = {
        if (list.isEmpty) h
        else fillAcc(insert(list.head, h), list.tail)
      }
      fillAcc(empty, list)
    }
    val heap = fillHeap(list)

    def compare(h: H, list: List[Int]): Boolean = {
      if(isEmpty(h) && !list.isEmpty) false
      else if(list.isEmpty && !isEmpty(h)) false
      else if(list.isEmpty && isEmpty(h)) true
      else if(list.head != findMin(h)) false
      else compare(deleteMin(h), list.tail)
    }
    
    compare(heap, list.sorted)
  }

  lazy val genHeap: Gen[H] = {
    for {
      isEmpty <- arbitrary[Boolean]
      heap <- oneOf(emptyHeap, nonEmptyHeap)
    } yield heap
  }

  val emptyHeap: Gen[H] = for {
    h <- empty
  } yield empty

  val nonEmptyHeap: Gen[H] = {
    for {
      x <- arbitrary[Int]
      h <- genHeap
    } yield insert(x, h)
  }

  implicit lazy val arbHeap: Arbitrary[H] = Arbitrary(genHeap)

}