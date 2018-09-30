# spark-exercises

This repository contains the skeleton for solving basic Spark exercises.

## Exercises

### Exercise 1

1. Load the data found in _data/web_events.log_ into an RDD. Take into account that each line 
contains an entry, and the _;_ has been used as separator. Each line contains:

```
sourceHost, timestamp, method, URL, HTTPCode
```

2. Obtain the number of events per host.
3. Obtain the number of events per HTTPCode.
4. Determine the number of different hosts.

**Notes**

* Use a case class WebEvent to represent each line.

### Exercise 2

1. Load the data found in _data/auth_events.log_ into an RDD. Each line contains the following 
elements.

```
timestamp, sourceHost, Process, Message
```

2. Obtain the number of events per host.
3. Obtain the number of events per process.
4. Filter those hosts that have at least one failed authentication, and one failed requests.
5. Obtain the percentage of successful web requests per host.
6. Obtain the percentage of successful authentication per host.

**Notes**

* Use a case class AuthEvent to represent each line.
* Step 4 requires a join operation.
* Consider computing step 5 and 6 using common transformations.

### Exercise 3

1. Load the file _data/web_events.csv_ using the Spark-CSV library provided by databricks.
2. Solve the scenarios presented in Exercise using SparkSQL when possible.

**Notes**

* The file contains a header.
* Each column is separated by _;_