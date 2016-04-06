/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/*

Implements an immutable scala implementation of an R List object.  An R List is a vector of objects of any time, with a
dense numeric index.  R Lists also, though, optionally have sparse keys.  This is therefore a valid R List:
1 :("", "beta")
2 :("a key", data.frame)
3 : ("", 12)

It is implemented here as a wrapper around a Seq, along with a Map for matching index names

 */
package org.apache.zeppelin.rinterpreter.rscala

// TODO:  Not yet implemented


/**
 * Created by aelberg on 8/5/15.
 */
class RList[R0 <: RObject](ref: String,
            objClass : Array[String],
             val nameMapper : Map[String, Int],
             val theObjects : Seq[R0]) extends RImplementedClass (Protocol.LIST ,
                             ref,
                              objClass)  with Seq[R0]
with Map[String, R0] {

  def this(makeFrom : RList,
           newMap : Map[String, Int],
           newObjects : Seq[R0]) = {
    this(makeFrom.ref, makeFrom.objClass, newMap, newObjects)
    this.clean = false
  }

  override def +[B1 <: R0](kv: (String, B1)): RList = new RList(this,
    nameMapper + ((kv._1 , theObjects.length + 1)),
    theObjects ++ Seq[R0](kv._2))

  override def length: Int = theObjects.length

  override def apply(idx: Int): RObject = theObjects.apply(idx)

  override def get(key: String): Option[R0] = nameMapper.get(key) match {
    case Some(x : Int) => Some(theObjects.apply(x))
    case None => None
  }

  private class ListIterator[R0](creator : RList[R0]) extends Iterator[(String, R0)] {
     var index : Int = 0
     def hasNext : Boolean = if (index < creator.theObjects.length) true
     else false

     def next : (String, R0) = {
       val name : String = nameMapper.find(_._2 == index) match {
         case Some((nm : String, x : Int)) => nm
         case None => ""
       }
       index = index + 1
       (name, theObjects(index - 1))
     }
  }

  override def iterator: Iterator[(String, R0)] = new ListIterator(this)

  override def -(key: String): RList [R0]= nameMapper.get(key) match {
    case None => this
    case Some(i : Int) => new RList(this, nameMapper - key, theObjects.drop(nameMapper.get(key).get))
  }
}

object RList {

  def apply(reference: RObjectRef, context : RClient): RList = {
    val rClass = context.getS1(s"""class(${reference})""")
    val names : Array[String] = context.getS1(s"""names(${reference})""")
    val temp = for (i <- Range(0, names.length);
      if names(i) != "") yield (names(i) -> i)

    val map : Map[String, Int] = temp.toMap
    val seq = Range(0, names.length).map( (x : Int) => context.getR(s"""${reference}[[${x}]]"""))
    val ret = new RList(reference.getRef(), rClass, map, seq)
    ret.clean = true
    ret
  }

}