install.packages("igraph")
require(igraph)
require(ggplot2)
install.packages("car")
library(car)

karate <- read.graph("http://cneurocvs.rmki.kfki.hu/igraph/karate.net",
                      format="pajek")
summary(karate)

# Vertex & Edges
vertexes <- get.data.frame(karate, what="vertices")
nodes <- V(karate)
edges <- E(karate)

# Graph metrics
diameter(karate)
farthest.nodes(karate)


# Nodes metrics
vertexes$degree <- degree(karate)
vertexes$closeness <- closeness(karate)
vertexes$betweenness <- betweenness(karate)
vertexes$pagerank <- page.rank(karate)$vector
plot(vertexes,pch=19,col="orange")



# Communities
sgc <- spinglass.community(karate)
vertexes$membership <- sgc$membership
modularity(karate, membership(sgc))
lc <- largest.cliques(karate)
lc


# Visualization

# found 4 communities  1, 2, 3, 4
vertexes$color[ vertexes$membership == 1 ] <- "cyan"
vertexes$color[ vertexes$membership == 2 ] <- "green"
vertexes$color[ vertexes$membership == 3 ] <- "blue"
vertexes$color[ vertexes$membership == 4 ] <- "red"

plot(karate, layout=layout.fruchterman.reingold, vertex.color=vertexes$color, vertex.size = V(karate)$size, vertex.label = NA, edge.arrow.size = 0.5)

