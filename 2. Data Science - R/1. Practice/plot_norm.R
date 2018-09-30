# El type="n" hace que el se cree la figura (ejes, titulos, etc) pero que
# no se represente nada
xval <- seq(-5,5,0.1)
plot(1, xlim=range(xval), ylim=c(0,1), xlab="x", ylab="Prob.", type="n")

# diferentes desviaciones y colores para cada una de ellas
desv <- c(0.5, 1, 2)
cols <- c("red", "blue", "green")

for (i in 1:length(desv)) {
  # calcular el valor de la distribucion normal para cada desviacion
  # tipica y añadirlo al grafico con un color distinto
  lines(xval, dnorm(xval, sd=desv[i]), col=cols[i])
}

# ejemplo de como añadir una leyenda a la figura
labels <- paste("Desv. estandar=",desv, sep="")
legend("topright", labels, lty=1, col=cols, inset=0.05)