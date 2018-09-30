# Funcion media con un argumento
media <- function(vector) {
  # si existe una variable z en el entorno se imprimiria su valor,
  # sino existe, la funcion da un error
  print(z)
  # las asignaciones son locales a la funcion
  ret <- sum(vector)/length(vector)
  ret
}

# la variable ret aqui no existe!!
x <- 1:10000
m <- media(x)

# argumentos con nombre
f <- function(x, y){
  x-y
}

f(5,6)
f(6,5)
f(x=6, y=5)
f(y=5, x=6)

# valores por defecto
f1 <- function(x, y=1){
  x-y
}

f1(6,5)
f1(5)
f1(y=5)
f1(x=5)