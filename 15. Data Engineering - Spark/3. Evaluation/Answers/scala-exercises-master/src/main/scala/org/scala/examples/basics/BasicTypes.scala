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

object BasicTypes {

  /**
   * Basic types main.
   * @param args The arguments.
   */
  def main(args: Array[String]) : Unit = {
    val types = new BasicTypes
    types.showTypes()
  }
}

/**
 * Basic types.
 */
class BasicTypes {

  /**
   * Integer number.
   */
  val intNumber : Int = 5

  /**
   * Long number.
   */
  val longNumber : Long = 10

  /**
   * Float number.
   */
  val floatNumber : Float = 3.14f

  /**
   * Double number.
   */
  val doubleNumber : Double = 3.14f

  /**
   * String value.
   */
  val stringValue : String = "String value"

  /**
   * Boolean value.
   */
  val booleanValue : Boolean = true

  /**
   * Lazy variable.
   */
  lazy val beingLazy : String = "Lazy"

  /**
   * Show types.
   */
  def showTypes() : Unit = {
    println(intNumber)
    println(longNumber)
    println(floatNumber)
    println(doubleNumber)
    println(stringValue)
    println(booleanValue)
    println(beingLazy)
  }

}
