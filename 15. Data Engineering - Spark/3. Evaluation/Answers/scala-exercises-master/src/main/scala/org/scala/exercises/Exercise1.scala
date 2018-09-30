/*
 * Copyright (c) 2015 Daniel Higuero.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.scala.exercises

object Exercise1 {
  def main(args: Array[String]) {
    println("Scala Exercise1 Alfonso Campos")
    val l = List(1,2,3,4,5)

    //println(myList.map(value => value * 2))
    //println(myList.reduce((a,b) => a+b))
    //println(myList.filter(_ > 3))
    //println(myList.fold(0)((acc,cur) => {acc + cur }))
    //println(myList.foldLeft(Map.empty[Int,Int])((acc,cur) => {acc + (cur -> cur *2)}))

    val e1 = new Exercise1

    println("\nExample 1 with FoldLeft")
    val ex1fl = e1.processListFL[Int,String](l, e1.transformToString)
    println (ex1fl)

    println("Example 1 with Map")
    val ex1m = e1.processListM[Int,String](l, e1.transformToString)
    println (ex1m)

    println("\nExample 2 with FoldLeft")
    val ex2fl = e1.processListFL[Int,Int](l, e1.square)
    println (ex2fl)

    println("Example 2 with Map")
    val ex2m = e1.processListM[Int,Int](l, e1.square)
    println (ex2m)
  }
}

/**
 * Class that provides the implementation for the solution of the exercise 1.
 */
class Exercise1 {
  def transformToString(value: Int): String = {
    "string: " + value.toString
  }

  def square(value: Int): Int = {
    value * value
  }

//  def processList[A,B](l:List[A], f: A => B) : Map[A,B] = {
//    l.foldLeft(Map.empty[A,B])((acc,cur) => {acc + (cur -> f(cur))})
//  }

  def processListFL[A,B](l:List[A], f: A => B) : Map[A,B] = {
    l.foldLeft(Map.empty[A,B])( (map, key) => map.updated(key, f(key)) )
  }

  def processListM[A,B](l:List[A], f: A => B) : Map[A,B] = {
    l.map( key => (key, f(key))).toMap
  }

}
