# scala-exercises

## Introduction

   The purpose of this repository is to provide an skeleton to solve a series of scala exercises.
   
## Exercises

### Exercise 1

Provide a generic method to process a list of any type and apply a function to the elements of
the list.

**Example 1**: Transform each element into an arbitrary string representation.
 
```
val l = List(1,2,3,4,5)
val r1 = processList(l, transformToString)
println(r1)
```

Output:

```
 Map(5 -> string: 5, 1 -> string: 1, 2 -> string: 2,
      3 -> string: 3, 4 -> string: 4) 
```

**Example 2**: Transform each number obtain its square value.

```
val r2 = processList(l, square)
println(r2)`
```

Output:

```
Map(5 -> 25, 1 -> 1, 2 -> 4, 3 -> 9, 4 -> 16)
```

**Notes**

* Provide two implementations. One of them must use *foldLeft*.
* The elements of the list can be of any type A.

### Exercise 2

Define a Person case class that contains the following attributes:

* name
* age
* mail

Code a method to obtain a map of users indexed by age.

```
def groupByAge(persons: List[Person]): Map[Int, List[Person]]
```

**Notes**

* Provide two implementations. One of them must use *foldLeft*.
* Generate a list of 50 persons using random names, mails, and ages.

### Exercise 3

1. Define a superclass called Vehicle.
2. Define two traits: AirVehicle, and GroundVehicle.
3. Define a class Car, Bus, Helicopter and Plane that extend both Vehicle and the previous traits. 
4. Each vehicle is identified by a name.
5. An air vehicle has the following attributes: airspeed, and maxSpeed.
6. A ground vehicle has a maxSpeed.

Provide a method to filter ground vehicles.

```
def filterGroundVehicles(vehicles: List[Vehicle]): List[GroundVehicle]
```

Provide a method to obtain the average maximum speed.

```
def getAverageMaxSpeed(vehicles: List[Vehicle]): Double
```

**Notes**

* Use pattern matching in the filter function.
* Generate a list of 50 vehicles using random values.


