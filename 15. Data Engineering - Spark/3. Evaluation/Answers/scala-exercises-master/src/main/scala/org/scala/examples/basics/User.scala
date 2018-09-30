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

object User{

  /**
   * Main.
   * @param args The arguments.
   */
  def main(args: Array[String]) : Unit = {
    // TODO 1) Build all types of users.
  }

}

/**
 * Class that demonstrates the use of constructors example.
 * @param email The email.
 * @param age The age.
 */
class User(email: String, age: Int = 20) {

  /**
   * Whether the user is registered.
   */
  var registered : Boolean = false

  /**
   * Alternate constructor.
   * @param email The email.
   * @param age The age.
   * @param registered Whether the user is registered.
   */
  def this(email: String, age: Int, registered: Boolean) = {
    this(email, age)
    this.registered = false
  }

  // TODO 2) Modify the User class to use an Option for the age.
  // TODO 3) Implement a toString method taking into account the option.
  // TODO 4) Add an apply method to the companion object.
}
