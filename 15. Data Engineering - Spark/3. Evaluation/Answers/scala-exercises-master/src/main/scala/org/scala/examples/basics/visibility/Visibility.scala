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

package org.scala.examples.basics.visibility

import org.scala.examples.basics.visibility.other.ClassC

object Visibility{

  /**
   * Visibility main.
   * @param args The arguments.
   */
  def main(args: Array[String]) : Unit = {
    val v = new Visibility
    v.checkVisibility()
    v.printPrivateValues()
  }
}

/**
 * Variable and method visibility.
 */
class Visibility {

  /**
   * Method to check the visibility.
   */
  private def checkVisibility() : Unit = {
    val a = new ClassA
    val b = new ClassB
    val c = new ClassC
    println(a.publicVal)
    println(b.publicVal)
    println(c.publicVal)
  }

  /**
   * Print the private values of ClassA, ClassB, and ClassC.
   */
  private def printPrivateValues() : Unit = {
    // TODO Add a new method in ClassA, ClassB, and ClassC to print the values.
  }

}
