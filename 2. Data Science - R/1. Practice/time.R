x <- 1:1000000
system.time(y <- x+1)

z <- numeric()
system.time(
  for(i in 1:length(x)) 
    z[i] <- x[i]+1
)

system.time(for(i in 1:length(x)) z[i] <- x[i]+1)