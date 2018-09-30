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

package org.spark.batch.examples

import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD

import scala.io.StdIn

/**
 * Spark skeleton application.
 */
object SparkSimpleApp {


  def main(args: Array[String]) : Unit = {

    // Suppress Spark output
    Logger.getLogger("org").setLevel(Level.ERROR)
    Logger.getLogger("akka").setLevel(Level.ERROR)

    // Define the Spark configuration. In this case we are using the local mode
    val sparkConf : SparkConf = new SparkConf().setMaster("local[2]").setAppName("Skeleton App")
    // Define the Spark context.
    val sc : SparkContext = new SparkContext(sparkConf)
    val FILE = "data/web_events.log"
    val rdd: RDD[String] = sc.textFile(FILE)
    println(rdd.foreach(println))
    // Create an example list filled with random doubles.
    val list : List[Double] = List.fill(1000)(Math.random())
    // Parallelize the list obtaining an RDD
    val rddList : RDD[Double]= sc.parallelize(list)
    // Filter those numbers greated that 0.5 and count them.
    val numFiltered : Long = rddList.filter(_ > 0.5).count()

    println("Number of filtered elements: " + numFiltered)
    println("Open http://localhost:4040 in your browser and check the status.")
    StdIn.readLine("Press enter to finish")
  }
}

