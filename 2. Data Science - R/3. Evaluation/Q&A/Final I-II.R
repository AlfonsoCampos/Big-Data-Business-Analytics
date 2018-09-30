#' ---	
#' output: pdf_document	
#' ---	
#' # Proyecto R CIFF 2015 - Alfonso Campos	
#' 	
#' ## Proyecto I 	
#' 	
#' ### Configuracion	
#' 	
# Variables de entorno	
# setwd("D:\\Dropbox\\Doc\\Actual\\CIFF\\R\\Entregas") # MODIFICAR!	
getwd()	
	
# Paquetes	
# install.packages("caTools") # INSTALAR!	
library(caTools) # Permite utilizar la funcion sample.split	
	
# Semilla	
set.seed(2000)	
#' 	
#' 	
#' ### Cargar los datos en R.	
#' 	
housing = read.table("housing")	
#' 	
#' 	
#' ### Realizar un analisis estadistico de las variables: calcular la media, varianza, rangos, etc. ¿Tienen las distintas variables rangos muy diferentes?	
#' 	
# Media y rangos	
summary(housing)	
	
# Varianza	
apply(housing, 2, var)	
#' 	
#' ```	
#' Podemos ver que las Variables V2 a V14 estan normalizadas. La variable V1 no lo 	
#' esta! Los rangos de las variables V2 a V14 son similares (-1 a 1), V1 tiene un 	
#' rango mayor (5 a 50).	
#' ```	
#' 	
#' ### Escalar los datos para que tengan media 0 y varianza 1, es decir, restar a cada variable su media y dividir por la desviacion tipica.	
#' 	
# Antes de escalar	
colMeans(housing)	
apply(housing, 2, var)	
	
# Escalado	
scaledHousing <- scale(housing)	
	
scaledHousing <- data.frame(lapply(housing, function(x) scale(x)))	
	
# Despues de escalar	
colMeans(scaledHousing) # estos valores son 0	
apply(scaledHousing, 2, var) # la varianza es 1	
#' 	
#' ```	
#' Podemos comprobar que hemos escalado correctamente los datos.	
#' ```	
#' 	
#' ### La variable de respuesta se encuentra en la primera columna, separarla del resto y calcular la correlacion de dicha variable con el resto.	
#' 	
cor(scaledHousing[,1], scaledHousing[,2:14])	
#' 	
#' ```	
#' Podemos ver que existen variables con mayor grado de correlacion positiva o 	
#' negativa que otras. La variable V14 tiene la mayor correlacion, mientras que la 	
#' variable V5 tiene la menor (hablando en valores absolutos).	
#' ```	
#' 	
#' ### Separar el conjunto de datos en dos, el primero (entrenamiento) conteniendo un 80% de los datos y el segundo (test) un 20%, de forma aleatoria.	
#' 	
spl = sample.split(scaledHousing$V1, SplitRatio = 0.8)	
scaledHousingTrain = subset(housing, spl==TRUE)	
scaledHousingTest = subset(housing, spl==FALSE)	
#' 	
#' ## Proyecto II	
#' 	
#' ### Realizar un modelo de regresion lineal de la variable de respuesta sobre el resto y ajustarlo por minimos cuadrados usando unicamente los datos del conjunto de entrenamiento.	
#' 	
housingModel <- lm(V1 ~ ., data = scaledHousingTrain)	
summary(housingModel)	
#' 	
#' ```	
#' Podemos ver que V4 y V8 no son significativas en nuestro modelo, cabe esperar 	
#' que suframos algo de sobreajuste.	
#' ```	
#' 	
#' ### Calcular el error cuadratico medio de los datos del conjunto de entrenamiento y de los datos del conjunto de test.	
#' 	
# Datos de entrenamiento	
housingModelPredTrain <- predict.lm(housingModel, newdata=scaledHousingTrain)	
mseTrain <- mean((housingModelPredTrain - scaledHousingTrain$V1)^2)	
mseTrain	
	
# Datos de test	
housingModelPredTest <- predict.lm(housingModel, newdata=scaledHousingTest)	
mseTest <- mean((housingModelPredTest - scaledHousingTest$V1)^2)	
mseTest	
#' 	
#' ```	
#' Los datos obtenidos indican que el error sobre los datos de test es ligeramente 	
#' mayor que sobre los datos de entrenamiento, lo cual parece razonable maxime 	
#' teniendo en cuenta algo de sobreajuste del modelo.	
#' ```	
