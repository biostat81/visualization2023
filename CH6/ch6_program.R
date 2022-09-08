### Program 6-1
library(dplyr)
library(tidygraph)
edge.data <- tibble(from = c(1, 2, 2, 3, 4, 4), to = c(2, 3, 4, 2, 1, 5))
node.data <- tibble(id = 1:5)
net.1<- tbl_graph(nodes = node.data, edges = edge.data, directed = TRUE)

### Program 6-2
library(ggraph)
net.hi<-as_tbl_graph(highschool) 

### Program 6-3
iris.clust<-hclust(dist(iris[, 1:4]))
net.iris<-as_tbl_graph(iris.clust)

### Program 6-4
ggraph(net.1) + geom_edge_link() + geom_node_point()

### Program 6-5
ggraph(net.hi) + geom_edge_link() + geom_node_point() + theme_graph()
ggraph(net.hi, layout="eigen") + geom_edge_link() + geom_node_point() + theme_graph()
ggraph(net.hi, layout="linear", circular=TRUE) + geom_edge_link() + geom_node_point() + coord_fixed()
set.seed(100)
ggraph(net.hi, layout="circlepack") + geom_edge_link() + geom_node_point() 

### Program 6-6
ggraph(net.iris, layout="dendrogram") + geom_edge_link() + geom_node_point() 
ggraph(net.iris, layout="dendrogram", height=height) + geom_edge_link() + geom_node_point() 


### Program 6-7
ggraph(net.1) + geom_edge_link() + geom_node_point(color="red", size=4) + theme_graph()
ggraph(net.1) + geom_edge_link() + geom_node_point(aes(color=centrality_power()), size=4) + labs(color="Centrality") + theme_graph()
ggraph(net.1) + geom_edge_link() + geom_node_label(aes(label=id)) + theme_graph()

### Program 6-8
ggraph(net.hi, layout = "stress") + geom_edge_link() + 
  geom_node_point(aes(filter = centrality_degree() > 3), color="Red")
ggraph(net.iris, layout="dendrogram", circular=TRUE) + geom_edge_link() + geom_node_point(aes(filter=leaf))  + coord_fixed()
ggraph(net.iris, layout="dendrogram", height=height) + geom_edge_link() 


### Program 6-9
ggraph(net.1) + geom_edge_link(arrow=arrow(), start_cap = circle(3, "mm"), end_cap = circle(3, "mm")) + 
  geom_node_point(size=4) 

### Program 6-10
edge.data2 <- tibble(from = c(1, 2, 2, 3, 4, 4), to = c(2, 3, 4, 2, 1, 5), 
                     amount=c(100, 40, 50, 60, 80, 30))
net.2<- tbl_graph(nodes = node.data, edges = edge.data2, directed = TRUE)
ggraph(net.2) + geom_edge_parallel(aes(edge_width=amount),
                                   arrow=arrow(), start_cap = circle(5, "mm"), end_cap = circle(5, "mm")) + 
  geom_node_label(aes(label=id)) + 
  scale_edge_width(range=c(0.2, 2)) + 
  theme_graph()

### Program 6-11
net.hi2<-net.hi %>% activate(edges) %>% mutate(year=as.factor(year))
ggraph(net.hi2) + geom_edge_link(aes(color=year)) + geom_node_point() 

### Program 6-12
ggraph(net.hi2) + geom_edge_fan(aes(color=year)) + geom_node_point() 
ggraph(net.hi2, layout="linear") + geom_edge_arc(aes(color=year)) + geom_node_point() 

### Program 6-13
ggraph(net.iris, layout="dendrogram", height=height) + geom_edge_elbow() 



