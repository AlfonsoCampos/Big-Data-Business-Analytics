package org.spark.batch.exercises

import org.apache.log4j.{Level, Logger}
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkContext, SparkConf}


object Exercise2{
  def main(args: Array[String]) : Unit = {
    val WEfile = "data/web_events.log"
    val AEfile = "data/auth_events.log"

    // Suppress Spark output
    Logger.getLogger("org").setLevel(Level.ERROR)
    Logger.getLogger("akka").setLevel(Level.ERROR)

    // Spark Initialization
    val sparkConf : SparkConf = new SparkConf().setMaster("local[2]").setAppName("Spark Exercise2 Alfonso Campos")
    val sc : SparkContext = new SparkContext(sparkConf)

    // Distribute File
    val WEText:RDD[String]= sc.textFile(WEfile)
    val AEText:RDD[String]= sc.textFile(AEfile)

    // Create WebEvent RDD
    val we = WEText.map(_.split(";")).map(p => WebEvent(p(0),p(1),p(2),p(3),p(4).toInt))
    val ae = AEText.map(_.split(";")).map(p => AuthEvent(p(0),p(1),p(2),p(3)))

    // Main
    val e2 = new Exercise2

    println("\nEventsPerHost")
    val eph = e2.getEventsPerHost(ae)
    eph.foreach {
      e => println("Host: " + e._1, "Events: " + e._2)
    }

    println("\nEventsPerProccess")
    val epp = e2.getEventsPerProcess(ae)
    epp.foreach {
      e => println("Process: " + e._1, "Events: " + e._2)
    }

    println("\nReliable Hosts: ")
    val ffar = e2.filterFailedAuthRequest(we, ae)
    ffar.foreach {
      e => print(e + " ")
    }

    println("\nHost - Successful Web Request")
    val swr = e2.getSuccessfulWebRequests(we)
    swr.foreach {
      e =>
        println(e._1 + " - %.2f%%".format(e._2))
    }

    println("\nHost - Successful Authentication")
    val sa = e2.getSuccessfulAuthentication(ae)
    sa.foreach {
      e =>
        println(e._1 + " - %.2f%%".format(e._2))
    }
  }
}
/**
 * Exercise 2.
 */
class Exercise2 {
  def getEventsPerHost(ae: RDD[AuthEvent]): RDD[(String,Int)] = {
    ae.groupBy(_.sourceHost).mapValues(_.size)
  }

  def getEventsPerProcess(ae: RDD[AuthEvent]): RDD[(String,Int)] = {
    ae.groupBy(_.Process).mapValues(_.size)
  }

  def filterFailedAuthRequest(we: RDD[WebEvent], ae:RDD[AuthEvent]):  RDD[(String)] = {
    val weg = we.map(x => (x.sourceHost, x.HTTPCode)).groupBy(_._1)
    val aeg = ae.map(x => (x.sourceHost, x.Message)).groupBy(_._1)

    val wa = weg.join(aeg).mapValues(a => (
        a._1.map(a => if (a._2 == 200) 1 else 0).reduce((a,b)=> a*b),
        a._2.map(a => if (a._2 contains "OK") 1 else 0).reduce((a,b)=> a*b)
      ))

    wa.filter(_._2._1 == 1).filter(_._2._2 == 1).map(_._1) //Parece que ningun Host tiene 0 fallos de autenticacion y logado
  }

  def getSuccessfulWebRequests(we: RDD[WebEvent]):  RDD[(String,Double)] = {
    val weg = we.map(x => (x.sourceHost, x.HTTPCode)).groupBy(_._1)
      .mapValues(a => a.map(a => if (a._2 == 200) 1 else 0).foldLeft(0.0)(_+_)/a.size*100)

    weg
  }

  def getSuccessfulAuthentication(ae: RDD[AuthEvent]):  RDD[(String,Double)] = {
    val aeg = ae.map(x => (x.sourceHost, x.Message)).groupBy(_._1)
      .mapValues(a => a.map(a => if (a._2 contains "OK") 1 else 0).foldLeft(0.0)(_+_)/a.size*100)

    aeg
  }
}

// Schema
case class AuthEvent(timestamp: String, sourceHost: String, Process: String, Message:String)