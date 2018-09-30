package org.spark.batch.exercises

import com.sun.jersey.spi.StringReader
import org.apache.log4j.{Level, Logger}
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkContext, SparkConf}

import scala.io.Source
import scala.io.StdIn
import scala.util.matching.Regex

object Exercise1{
  def main(args: Array[String]) : Unit = {
    val FILE = "data/web_events.log"

    // Suppress Spark output
    Logger.getLogger("org").setLevel(Level.ERROR)
    Logger.getLogger("akka").setLevel(Level.ERROR)

    // Spark Initialization
    val sparkConf : SparkConf = new SparkConf().setMaster("local[2]").setAppName("Spark Exercise1 Alfonso Campos")
    val sc : SparkContext = new SparkContext(sparkConf)

    // Distribute File
    val WEText:RDD[String]= sc.textFile(FILE)

    // Create WebEvent RDD
    val we = WEText.map(_.split(";")).map(p => WebEvent(p(0),p(1),p(2),p(3),p(4).toInt))

    // Main
    val e1 = new Exercise1

    println("\nEventsPerHost")
    val eph = e1.getEventsPerHost(we)
    eph.foreach {
      e => println("Host: " + e._1, "Events: " + e._2)
    }

    println("\nEventsPerHTTPCode")
    val ephc = e1.getEventsPerHTTPCode(we)
    ephc.foreach {
      e => println("HTTPCode: " + e._1, "Events: " + e._2)
    }

    val uhc = e1.getUniqueHostCount(we)
    println("\nUnique Hosts: " + uhc)
  }
}

/**
 * Exercise 1.
 */
class Exercise1 {
  def getEventsPerHost(we: RDD[WebEvent]): RDD[(String,Int)] = {
    we.groupBy(_.sourceHost).mapValues(_.size)
  }

  def getEventsPerHTTPCode(we: RDD[WebEvent]): RDD[(Int,Int)] = {
    we.groupBy(_.HTTPCode).mapValues(_.size)
  }

  def getUniqueHostCount(we: RDD[WebEvent]): Long = {
    we.groupBy(_.sourceHost).count
  }
}

// Schema
case class WebEvent(sourceHost: String, timestamp: String, method: String, URL:String, HTTPCode: Int)