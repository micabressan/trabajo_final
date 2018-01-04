package jp.ac.nii.jardine.poplar

object ConditionSet {
  def apply(conditions: Iterable[Condition[_]] = Set()) = new ConditionSet(conditions)
}

class ConditionSet (val conditions: Iterable[Condition[_]] = Set()) {
  
  def substitute(from: Subject, to: Subject): ConditionSet = {
    new ConditionSet(conditions.map(_.substitute(from, to)))
  }
  
  def apply(s: Subject) = new ConditionSet(conditions.filter(_.subject == s))
  def except(s: Subject) = new ConditionSet(conditions.filter(_.subject != s))
  
  def toPlus = new ConditionSet(conditions.map(_.toPlus))
  def toEquals = new ConditionSet(conditions.map(_.toEquals))
  def toMinus= new ConditionSet(conditions.map(_.toMinus))
  
  def preconditions = new ConditionSet(conditions.collect { case i: Invariant => i; case s: Subtraction => s })
  def postconditions = new ConditionSet(conditions.collect { case i: Invariant => i; case a: Addition => a; case da: DirectAddition => da })
  def added = new ConditionSet(conditions.collect { case a: Addition => a; case da: DirectAddition => da }).toPlus
  def newPostconditions = new ConditionSet(conditions.collect { case da: DirectAddition => da })
  
  def directAddition = conditions.collect { case da: DirectAddition => da }
  def plus = conditions.collect { case a: Addition => a }
  def plusSet = new ConditionSet(plus)
  def equals = conditions.collect { case i: Invariant => i }
  def equalsSet = new ConditionSet(equals)
  def minus = conditions.collect { case s: Subtraction => s }
  def minusSet = new ConditionSet(minus)
  
  def intersect(other: ConditionSet) = new ConditionSet(conditions.toSet intersect other.conditions.toSet)
  
  def ++(more: Iterable[Condition[_]]) = new ConditionSet(conditions ++ more)
  def ++(more: ConditionSet) = new ConditionSet(conditions ++ more.conditions)
  def --(less: Iterable[Condition[_]]) = new ConditionSet(conditions.toSet -- less)
  def --(less: ConditionSet) = new ConditionSet(conditions.toSet -- less.conditions)
  
  def filter(f: Condition[_] => Boolean) = new ConditionSet(conditions.filter(f))
  def map[T](f: Condition[_] => T) = conditions.map(f)
  def isEmpty = conditions.isEmpty
  
  override def toString: String = {
    "CS(" + conditions.foldLeft("")(_+", "+_) + ")"
  }
  
  def checkSanity() = {
    assert (plusSet.toEquals.intersect(minusSet.toEquals).isEmpty)
    assert (plusSet.toEquals.intersect(equalsSet).isEmpty)
    assert(minusSet.toEquals.intersect(equalsSet).isEmpty)
  }
}
 

trait Condition[T] {
  def subject: Subject
  def label: Label

  def substitute(from: Subject, to: Subject): Condition[T]
  
  def toPlus = new Addition(subject, label)
  def toEquals = new Invariant(subject, label)
  def toMinus = new Subtraction(subject, label)
  
}

case class Invariant(subject: Subject, label: Label) extends Condition[Invariant] {
  def substitute(from: Subject, to: Subject) = {
    if (subject == from) {
    	new Invariant(to, label)
    } else {
      this
    }
  }
}

case class Addition(subject: Subject, label: Label) extends Condition[Addition]		    {      	// + @labelW
  def substitute(from: Subject, to: Subject) = {
    if (subject == from) {
    	new Addition(to, label)
    } else {
      this
    }
  }
}
case class DirectAddition(subject: Subject, label: Label) extends Condition[DirectAddition]	{	// ++@propertyX
 def substitute(from: Subject, to: Subject) = {
    if (subject == from) {
    	new DirectAddition(to, label)
    } else {
      this
    }
  }
}

case class Subtraction(subject: Subject, label: Label) extends Condition[Subtraction] {		    // - @propertyY
 def substitute(from: Subject, to: Subject) = {
    if (subject == from) {
    	new Subtraction(to, label)
    } else {
      this
    }
  }
}