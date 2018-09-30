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

object Exercise2{
  def main(args: Array[String]) {
    println("Scala Exercise2 Alfonso Campos")

    // Constants
    val MIN_AGE = 18
    val MAX_AGE = 100

    val MIN_LEN = 5
    val MAX_LEN = 10

    val MAIL_TYPE = "@gmail.com"

    // Main
    val e2 = new Exercise2
    val r = scala.util.Random

    var persons = List[Person]()

    // Instantiate 50 Persons
    for(_ <- 1 to 50){
        val name = r.alphanumeric.take(MIN_LEN + r.nextInt(MAX_LEN - MIN_LEN)).mkString
        val age = MIN_AGE + r.nextInt(MAX_AGE -  MIN_AGE)
        persons = Person(name, age, name.toLowerCase + MAIL_TYPE) :: persons
    }

    println(persons)

    println("\nGroupByAge with FoldLeft")
    val ex2fl = e2.groupByAgeFL(persons)
    println (ex2fl)

    println("\nGroupByAge with GroupBy")
    val ages = e2.groupByAgeGB(persons)
    println (ages)
  }
}

/**
 * Class that provides the implementation for the solution of the exercise 2.
 */
class Exercise2 {
  def groupByAgeGB(persons: List[Person]): Map[Int, List[Person]] = {
    persons.groupBy(_.age)
  }

  def groupByAgeFL(persons: List[Person]): Map[Int, List[Person]] = {
    persons.foldLeft(Map.empty[Int, List[Person]]) ( (map, key) =>
      map.get(key.age) match {
        case Some(e) =>  map.updated(key.age, key :: e)
        case None    => map + (key.age -> List(key))
      })
  }
}

case class Person(name: String, age: Int, mail: String)