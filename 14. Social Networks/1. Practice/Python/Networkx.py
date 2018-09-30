import itertools
import random

import matplotlib.pyplot as plt
import networkx as nx
import numpy as np

# Initialize graph
G=nx.Graph()

# Add nodes
nodes = [i for i in range(50)]
G.add_nodes_from(nodes)

# Add edges
n_edges = random.randint(200,400)
edges = [(random.randint(0,499),random.randint(0,499)) for i in range(n_edges)]
G.add_edges_from(edges)


# nodes
print G.nodes()[0:10]

# number of nodes
print "# nodes: ", G.number_of_nodes()

# edges
print G.edges()[0:10]

# number of edges
print "# edges: ",G.number_of_edges()


# Graph with attributes

FG=nx.Graph()

edges = [(random.randint(0,n_edges-1),random.randint(0,n_edges-1), random.random()) for i in range(n_edges)]

FG.add_weighted_edges_from(edges)

for n,nbrs in FG.adjacency_iter():
	for nbr,eattr in nbrs.items():
		data=eattr['weight']
		if data<0.5: print('(%d, %d, %.3f)' % (n,nbr,data))


# Centrality metrics
nx.connected_components(FG)
nx.degree(FG)
nx.closeness_centrality(FG)
nx.betweenness_centrality(FG)
nx.pagerank(FG, alpha=0.9)

# Clustering
clusters = nx.clustering(FG)
print clusters[0:100]


# plot graph
nx.draw_random(FG)
plt.show()

# Finding Motifs

target = nx.Graph()
target.add_edge(1,2)
target.add_edge(2,3)
num = 0

for sub_nodes in itertools.combinations(FG.nodes(),len(target.nodes())):
	subg = FG.subgraph(sub_nodes)
	if nx.is_connected(subg) and nx.is_isomorphic(subg, target):
		print subg.edges()
	if num > 100:
		break
	num += 1


