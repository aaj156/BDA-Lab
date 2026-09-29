# 🧪 **BDA LAB: Social Network Analysis using R (Community Detection)**

---

## 🎯 **1. Objective**

To perform **Social Network Analysis (SNA)** using R and implement **Community Detection algorithms** to identify groups within a network.

---

## 🧠 **2. Learning Outcomes**

After this experiment, students will be able to:

* Understand graph/network concepts
* Create and visualize networks in R
* Apply community detection algorithms
* Interpret clusters and relationships

---

## 🧰 **3. Tools & Libraries**

* R
* RStudio
* Libraries:

  * igraph
  * tidygraph
  * ggraph

---

## ⚙️ **4. Environment Setup**

### Install Packages

```r
install.packages("igraph")
install.packages("tidygraph")
install.packages("ggraph")
```

### Load Libraries

```r
library(igraph)
library(tidygraph)
library(ggraph)
```

---

# 📂 **5. Dataset (Edge List Format)**

Save as `network.csv`:

```csv
source,target
A,B
A,C
B,C
B,D
C,D
D,E
E,F
F,G
G,H
H,E
C,E
B,F
A,G
```

---

## 📥 **6. Load Data**

```r
edges <- read.csv("network.csv")
head(edges)
```

---

## 🔗 **7. Create Graph**

```r
g <- graph_from_data_frame(edges, directed = FALSE)
print(g)
```

---

## 🔍 **8. Basic Network Analysis**

### Number of Nodes & Edges

```r
vcount(g)
ecount(g)
```

### Degree of Nodes

```r
degree(g)
```

### Network Density

```r
edge_density(g)
```

---

## 🎨 **9. Network Visualization**

```r
plot(g,
     vertex.size = 30,
     vertex.label.cex = 1,
     edge.width = 2)
```

---

# 🧠 **10. Community Detection Algorithms**

---

## 🔹 1. Louvain Method (Most Important ⭐)

```r
louvain_comm <- cluster_louvain(g)
membership(louvain_comm)
```

### Visualization

```r
plot(louvain_comm, g)
```

---

## 🔹 2. Girvan-Newman (Edge Betweenness)

```r
gn_comm <- cluster_edge_betweenness(g)
plot(gn_comm, g)
```

---

## 🔹 3. Walktrap Algorithm

```r
walktrap_comm <- cluster_walktrap(g)
plot(walktrap_comm, g)
```

---

## 🔹 4. Fast Greedy Algorithm

```r
fg_comm <- cluster_fast_greedy(g)
plot(fg_comm, g)
```

---

# 📊 **11. Compare Algorithms**

```r
modularity(louvain_comm)
modularity(gn_comm)
modularity(walktrap_comm)
```

👉 Higher modularity = better community structure

---

# 📈 **12. Advanced Metrics**

## Betweenness Centrality

```r
betweenness(g)
```

## Closeness Centrality

```r
closeness(g)
```

## PageRank

```r
page.rank(g)$vector
```

---

# 📉 **13. Real Visualization using ggraph**

```r
library(ggraph)

ggraph(g, layout = "fr") +
  geom_edge_link() +
  geom_node_point(aes(color = as.factor(membership(louvain_comm))), size = 5) +
  geom_node_text(aes(label = name), vjust = 1.5) +
  theme_void()
```

---

# 🧪 **14. Tasks for Students**

1. Create your own network dataset
2. Apply Louvain algorithm
3. Compare with Walktrap
4. Identify most influential node
5. Visualize clusters

---

# 🚀 **15. Mini Project**

## Title:

**Social Network Analysis of Online Communities**

### Dataset Options:

* Facebook network
* Twitter follower graph
* GitHub collaboration network

---

## Tasks:

* Build graph
* Detect communities
* Identify influencers
* Compare algorithms
* Visualize network

---

# ⏱️ **16. Benchmarking**

```r
system.time(cluster_louvain(g))
system.time(cluster_edge_betweenness(g))
```

---

## 📊 Expected Observation

| Algorithm     | Speed  | Accuracy |
| ------------- | ------ | -------- |
| Louvain       | Fast   | High     |
| Walktrap      | Medium | Good     |
| Girvan-Newman | Slow   | High     |

---

# ❓ **17. Viva Questions**

1. What is a graph in SNA?
2. What is community detection?
3. Difference between Louvain and Girvan-Newman?
4. What is modularity?
5. What is centrality?

---

# 📌 **18. Conclusion**

Community detection helps uncover hidden structures in networks such as:

* Social groups
* Customer segments
* Collaboration clusters

---

# ✅ **End of Experiment**
