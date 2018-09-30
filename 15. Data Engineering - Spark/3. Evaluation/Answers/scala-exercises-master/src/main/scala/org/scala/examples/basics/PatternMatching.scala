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

package org.scala.examples.basics

/**
 * Pattern matching example.
 */
object PatternMatching {

  /**
   * Process any element using pattern matching.
   * @param element The element.
   * @return A string with the description.
   */
  def process(element: AnyRef) : String = {
    element match {
      case Car("MyModel", speed) => "A specific car with max speed of:" + speed
      case Car(_, speed) => if(speed > 150){ "A fast car" }else{ "A normal car" }
      case Motorbike(m, s) => s"A ${m} motorbike with max speed ${s}"
      case Bike(_) => "Just a bike"
      case _ => "Unknown"
    }
  }

  /**
   * Main.
   * @param args The arguments.
   */
  def main(args: Array[String]) : Unit = {
    println(process(Car("m1", 200)))
    println(process(Car("MyModel", 200)))
    println(process(Car("m2", 100)))
    println(process(Motorbike("m3", 100)))
    println(process(Bike("m3")))
    println(process("Something"))
  }
}

case class Car(model: String, maxSpeed: Int)
case class Motorbike(model: String, maxSpeed: Int)
case class Bike(model: String)
