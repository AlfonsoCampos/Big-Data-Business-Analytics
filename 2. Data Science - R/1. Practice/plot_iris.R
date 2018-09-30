plot_iris <- function(X, tipos)
{
  niveles <- levels(tipos)
  colores <- c("red", "blue", "green")

  plot(X, type="n")
  for(i in 1:length(niveles)) {
    idx <- tipos == niveles[i]
    points(X[idx,], pch=16, col=colores[i])
  }
}

combs <- combn(names(iris)[1:4], 2)

par(mfrow=c(3,2))
for(j in 1:ncol(combs)) {
  plot_iris(iris[ ,combs[,j]], iris[, "Species"])
}