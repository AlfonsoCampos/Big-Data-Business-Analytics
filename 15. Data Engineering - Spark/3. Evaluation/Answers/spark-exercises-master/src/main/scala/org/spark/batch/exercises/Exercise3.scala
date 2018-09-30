package org.spark.batch.exercises

import org.apache.log4j.{Level, Logger}
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkContext, SparkConf}
import org.apache.spark.sql.{DataFrame, SQLContext}

object Exercise3{
  def main(args: Array[String]) : Unit = {
    val WEcsv = "data/web_events.csv"

    // Suppress Spark output
    Logger.getLogger("org").setLevel(Level.ERROR)
    Logger.getLogger("akka").setLevel(Level.ERROR)

    // Spark Initialization
    val sparkConf: SparkConf = new SparkConf().setMaster("local[2]").setAppName("Spark Exercise2 Alfonso Campos")
    val sc: SparkContext = new SparkContext(sparkConf)

    // Dataframe Initialization
    val sqlContext = new SQLContext(sc)
    val we = sqlContext.read
      .format("com.databricks.spark.csv")
      .option("header", "true") // Use first line of all files as header
      .option("inferSchema", "true") // Automatically infer data types
      .option("delimiter",";")
      .load(WEcsv)

    // Main
    val e3 = new Exercise3

    println("\nEventsPerHost")
    val eph = e3.getEventsPerHost(we)
    eph.show(100)

    println("\nEventsPerHTTPCode")
    val ephc = e3.getEventsPerHTTPCode(we)
    ephc.show

    val uhc = e3.getUniqueHostCount(we)
    println("\nUnique Hosts: " + uhc)
  }
}

/**
 * Exercise3.
 */
class Exercise3 {
  def getEventsPerHost(we: DataFrame): DataFrame = {
    we.groupBy("sourceHost").count()
  }

  def getEventsPerHTTPCode(we: DataFrame): DataFrame = {
    we.groupBy("HTTPCode").count()
  }

  def getUniqueHostCount(we: DataFrame): Long = {
    we.select("sourceHost").distinct().count()
  }
}
