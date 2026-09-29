# 🧪 **BDA LAB: Advanced Social Network Analysis using R**

## (Real Facebook/Twitter Dataset + Community Detection + Link Prediction + Graph ML)

---

# 🎯 **1. Objective**

To perform **advanced Social Network Analysis (SNA)** using:

* Real-world large datasets (Facebook / Twitter)
* Community detection
* Link prediction
* Graph ML concepts

---

# 🌐 **2. Real Dataset Sources (IMPORTANT)**

## 🔵 Facebook Dataset (SNAP)

Download:
[Facebook Ego Network Dataset](https://snap.stanford.edu/data/ego-Facebook.html?utm_source=chatgpt.com)

### 📊 Details:

* Nodes: 4039
* Edges: 88,234
* Undirected network
* Includes social circles

👉 Suitable for **community detection + visualization**

---

## 🐦 Twitter Dataset (SNAP)

Download:
[Twitter Ego Network Dataset](https://snap.stanford.edu/data/ego-Twitter.html?utm_source=chatgpt.com)

### 📊 Details:

* Nodes: 81,306
* Edges: 1,768,149
* Directed network

👉 Suitable for **large-scale SNA + Graph ML**

---

## 🔥 Large Scale Dataset (Advanced)

Download:
[Higgs Twitter Dataset](https://snap.stanford.edu/data/higgs/web/twitter-higgs.html?utm_source=chatgpt.com)

### 📊 Details:

* Nodes: 456,631
* Edges: 14.8M
* Multi-layer network (retweet, reply, mention)

👉 Ideal for **Graph ML + Link Prediction research**

---

# ⚙️ **3. Setup**

```r
install.packages("igraph")
install.packages("ggraph")
install.packages("tidygraph")
```

```r
library(igraph)
library(ggraph)
library(tidygraph)
```

---

# 📥 **4. Load Real Dataset**

After downloading:

### Example (Facebook edges)

```r
edges <- read.table("facebook_combined.txt", header=FALSE)
colnames(edges) <- c("source","target")

g <- graph_from_data_frame(edges, directed=FALSE)
```

---

# 🔍 **5. Basic Network Analysis**

```r
vcount(g)
ecount(g)
degree(g)
edge_density(g)
```

---

# 🎨 **6. Visualization**

```r
plot(g, vertex.size=3, vertex.label=NA)
```

---

# 🧠 **7. Community Detection**

## Louvain

```r
comm <- cluster_louvain(g)
plot(comm, g)
```

## Walktrap

```r
comm2 <- cluster_walktrap(g)
```

---

# 📊 **8. Modularity Comparison**

```r
modularity(comm)
modularity(comm2)
```

---

# 🚀 **9. Advanced SNA: Link Prediction**

---

## 🔹 Concept

Predict **future connections** between nodes.

---

## 🔹 Method 1: Common Neighbors

```r
common_neighbors <- function(g, node1, node2) {
  length(intersect(neighbors(g, node1), neighbors(g, node2)))
}
```

---

## 🔹 Method 2: Jaccard Similarity

```r
similarity(g, method="jaccard")
```

---

## 🔹 Method 3: Adamic-Adar Index

```r
similarity(g, method="invlogweighted")
```

---

# 🧠 **10. Graph ML (Advanced Concepts)**

---

## 🔹 Feature Extraction

```r
V(g)$degree <- degree(g)
V(g)$betweenness <- betweenness(g)
V(g)$pagerank <- page.rank(g)$vector
```

---

## 🔹 Node Embeddings (Concept)

Graph ML uses:

* Node2Vec
* DeepWalk
* GraphSAGE

👉 Converts graph → vector representation

---

## 🔹 Example (Simple ML Workflow)

```r
features <- data.frame(
  degree = degree(g),
  betweenness = betweenness(g)
)
```

Use in:

* Classification
* Clustering
* Prediction

---

# 🔮 **11. Link Prediction using ML (Conceptual)**

### Steps:

1. Create node pair dataset

2. Extract features:

   * Common neighbors
   * Jaccard score

3. Label:

   * 1 (edge exists)
   * 0 (no edge)

4. Train model:

```r
# Example using logistic regression
model <- glm(label ~ feature1 + feature2, family="binomial", data=data)
```

---

# 📉 **12. Subgraph Sampling (For Large Data)**

```r
subg <- induced_subgraph(g, vids=sample(V(g), 500))
plot(subg)
```

---

# ⏱️ **13. Benchmarking**

```r
system.time(cluster_louvain(g))
system.time(cluster_walktrap(g))
```

---

# 📊 **14. Sample Interpretation**

* Dense clusters → strong communities
* High centrality → influencers
* High similarity → likely future connections

---

# 🧪 **15. Student Tasks**

1. Apply Louvain on Facebook dataset
2. Compare with Walktrap
3. Perform link prediction
4. Identify influencers
5. Visualize communities

---

# 🚀 **16. Mini Project**

## Title:

**Social Network Intelligence using Graph ML**

### Tasks:

* Use Twitter dataset
* Detect communities
* Predict future links
* Identify influencers

---

# 📌 **17. Advanced Extensions**

* Graph Neural Networks (GNN)
* Temporal network analysis
* Fraud detection using graphs

---

# ❓ **18. Viva Questions**

1. What is link prediction?
2. What is modularity?
3. Difference between Louvain & Girvan-Newman?
4. What is Graph ML?
5. What are node embeddings?

---

# 📘 **19. Conclusion**

This experiment covers:

* Real-world large-scale SNA
* Community detection
* Link prediction
* Graph Machine Learning

---

# ✅ **END OF ADVANCED LAB**
