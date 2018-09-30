read.dataset <- function(file, response=1, ...) {
  
  data <- read.table(file, ...)
  
  X <- as.matrix(data[,-response])
  y <- data[,response]
  
  dataset <- list(x=X, y=y)
  return(dataset)
}