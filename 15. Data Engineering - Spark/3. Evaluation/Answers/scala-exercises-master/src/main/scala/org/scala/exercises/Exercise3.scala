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

object Exercise3{
  def main(args: Array[String]) {
    println("Scala Exercise3 Alfonso Campos")

    // Constants
    val SPEED_FACTOR = 200
    val MIN_LEN = 5
    val MAX_LEN = 10

    val NUM_SUBCLASSES = 5

    // Main
    val e3 = new Exercise3
    val r = scala.util.Random

    var vehicles = List[Vehicle]()

    // Instantiate 50 Persons
    for(_ <- 1 to 5){
      val name = r.alphanumeric.take(MIN_LEN + r.nextInt(MAX_LEN - MIN_LEN)).mkString
      val speed = r.nextDouble() * SPEED_FACTOR
      val speed2 = r.nextDouble() * SPEED_FACTOR * 2

      r.nextInt(NUM_SUBCLASSES) match {
        case 0 => vehicles = new Car(name, speed) :: vehicles
        case 1 => vehicles = new Bus(name, speed) :: vehicles
        case 2 => vehicles = new Helicopter(name, speed, speed2) :: vehicles
        case 3 => vehicles = new Plane(name, speed, speed2) :: vehicles
        case 4 => vehicles = new Transformer(name, speed, speed2) :: vehicles
      }
    }

    println(vehicles)

    println("\nFilter Ground Vehicles")
    val ex1fgv = e3.filterGroundVehicles(vehicles)
    println (ex1fgv)

    println("\nGet Average Max Speed")
    val ex1ams = e3.getAverageMaxSpeed(vehicles)
    println (ex1ams)
  }
}

/**
 * Class that provides the implementation for the solution of the exercise 3.
 */
class Exercise3 {
  def filterGroundVehicles(vehicles: List[Vehicle]): List[GroundVehicle] = { // No gestiona bien la herencia, porque?
    vehicles.filter(r => r match {case r:GroundVehicle => true case r:AirVehicle => false}).map(r => r.asInstanceOf[GroundVehicle])
  }

  def getAverageMaxSpeed(vehicles: List[Vehicle]): Double = {
    vehicles.foldLeft(0.0)( _ + _.maxSpeed ) / vehicles.length
  }
}

abstract class Vehicle(name: String, val maxSpeed : Double)

trait AirVehicle {
  def airSpeed: Double
}

trait GroundVehicle {
}

case class Car(name: String, override val maxSpeed : Double) extends Vehicle(name, maxSpeed) with GroundVehicle
case class Bus(name: String, override val maxSpeed : Double) extends Vehicle(name, maxSpeed) with GroundVehicle

case class Helicopter(name: String, override val maxSpeed : Double, airSpeed: Double) extends Vehicle(name, maxSpeed) with AirVehicle
case class Plane(name: String, override val maxSpeed : Double, airSpeed:Double) extends Vehicle(name, maxSpeed) with AirVehicle
case class Transformer(name: String, override val maxSpeed : Double, airSpeed:Double) extends Vehicle(name, maxSpeed)
  with AirVehicle with GroundVehicle