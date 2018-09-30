# numeros enteros aleatorios
rand_int <- sample(1:10, 1000, replace=T)
unique(rand_int)
table(rand_int)

# histograma donde se puede ver que la probabilidad
# de cada uno es aproximadamente 0.1
hist(rand_int, probability=TRUE, breaks=0:10)

# permutacion
perm <- sample(1:100, 100)

# o simplemente
perm <- sample(100)

# escoger 10 elementos aleatorios de iris
iris[sample(nrow(iris), 10), ]

# otra forma
iris[sample(nrow(iris)), ][1:10, ]