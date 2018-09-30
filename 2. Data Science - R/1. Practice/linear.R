# Hacer un ajuste de minimos cuadrados de mpg sobre wt, 
# es decir, queremos predecir el consumo (mpg) a partir del
# peso (wt).
fit <- lm(mpg ~ wt, data=mtcars)

# Scatter plot
plot(mtcars$wt, mtcars$mpg)

# Recta de regresion superpuesta al scatter plot
abline(fit)

# Valor que predice la recta de regresion para cada observacion
y_pred <- predict.lm(fit, newdata=mtcars)

# Error de la recta de regresion
mse <- mean((y_pred - mtcars$mpg)^2)
cat("Mean squared error:", mse, "\n")

# Ahora queremos predecir el consumo pero usando todas las
# variables restantes (.)
fit_all <- lm(mpg ~ ., data=mtcars)

# Error del modelo con todas las variables (deberia ser bastante menor
# que el error de la recta con una sola variable)
y_pred <- predict.lm(fit_all, newdata=mtcars)
mse <- mean((y_pred - mtcars$mpg)^2)
cat("Mean squared error:", mse, "\n")

# Otra manera: separar el data frame en una matriz de datos X
# y un vector de respuesta y (la variable que queremos predecir,
# mpg, está en la primera columna)
X <- as.matrix(mtcars[,-1])
y <- mtcars[,1]
 
# Ajustamos el modelo lineal y = Xw + b
fit <- lsfit(X, y)
 
# Los coeficientes del modelo w se obtienen con la función coef.
# Nota: el primer elemento de w es el valor del termino independiente b
w <- coef(fit)

# Para predecir basta con multiplicar la matriz X por w 
# Nota: para tener en cuenta el termino independiente se 
# puede añadir una columna de 1s en la matriz X, es decir:
y_pred <- cbind(rep(1, nrow(X)), X) %*% w

# Otra forma equivalente es separarlo de forma explícita
b <- w[1]
w <- w[-1]

y_pred1 <- X %*% w + b

# Calculamos el error, deberia ser exactamente el mismo que antes
mse <- mean((y_pred - y)^2)
cat("Mean squared error:", mse, "\n")

# Diferencia entre añadir la columna de 1s y separar el termino
# independiente de forma explicita, deberia ser practicamente 0
cat("Diferencia:", mean(abs(y_pred - y_pred1)), "\n")