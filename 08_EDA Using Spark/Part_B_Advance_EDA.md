# 🧪 **BDA LAB: Advanced Exploratory Data Analysis using PySpark**

---

## 🎯 **1. Objective**

To perform **basic → advanced Exploratory Data Analysis (EDA)** using PySpark on a **real-world dataset**, including:

* Data cleaning & transformation
* Advanced aggregations
* Window functions
* Feature engineering
* Performance benchmarking

---

## 🧠 **2. Learning Outcomes**

Students will be able to:

* Work with large datasets in PySpark
* Apply advanced transformations
* Use window functions
* Perform feature engineering
* Optimize Spark jobs using caching & partitioning

---

## 🧰 **3. Tools Required**

* Python 3.x
* PySpark
* Jupyter Notebook / VS Code

---

## ⚙️ **4. Environment Setup**

```bash
pip install pyspark pandas matplotlib seaborn
```

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Advanced_EDA_Lab") \
    .getOrCreate()
```

---

# 📂 **5. Real-Time Dataset: Online Retail Dataset**

### 📌 Dataset Description

Simulated e-commerce transaction data.

Save as `retail_data.csv`:

```csv
InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
10001,85123A,WHITE HANGING HEART T-LIGHT HOLDER,6,2024-01-01 10:00,2.55,17850,UK
10002,71053,WHITE METAL LANTERN,6,2024-01-01 10:05,3.39,17850,UK
10003,84406B,CREAM CUPID HEARTS COAT HANGER,8,2024-01-01 10:10,2.75,13047,France
10004,84029G,KNITTED UNION FLAG HOT WATER BOTTLE,6,2024-01-01 10:15,3.39,12583,Germany
10005,84029E,RED WOOLLY HOTTIE WHITE HEART,6,2024-01-01 10:20,3.39,13748,UK
10006,22752,SET 7 BABUSHKA NESTING BOXES,2,2024-01-01 10:25,7.65,15100,India
10007,21730,GLASS STAR FROSTED T-LIGHT HOLDER,6,2024-01-01 10:30,4.25,17850,UK
```

---

## 📥 **6. Data Loading**

```python
df = spark.read.csv("retail_data.csv", header=True, inferSchema=True)
df.show()
```

---

## 🔍 **7. Basic EDA**

```python
df.printSchema()
df.describe().show()
df.select("Country").distinct().show()
```

---

# 🧹 **8. Data Cleaning (Advanced)**

### 🔹 Handle Missing Values

```python
df = df.na.drop()
```

### 🔹 Remove Negative Quantities (returns/refunds)

```python
df = df.filter(df.Quantity > 0)
```

### 🔹 Remove Invalid Prices

```python
df = df.filter(df.UnitPrice > 0)
```

---

# 🔄 **9. Feature Engineering**

### 🔹 Create Total Price Column

```python
from pyspark.sql.functions import col

df = df.withColumn("TotalPrice", col("Quantity") * col("UnitPrice"))
```

---

### 🔹 Extract Date Features

```python
from pyspark.sql.functions import to_timestamp, month, year

df = df.withColumn("InvoiceDate", to_timestamp("InvoiceDate"))
df = df.withColumn("Month", month("InvoiceDate"))
df = df.withColumn("Year", year("InvoiceDate"))
```

---

# 📊 **10. Advanced Aggregations**

### 🔹 Revenue by Country

```python
df.groupBy("Country").sum("TotalPrice").show()
```

### 🔹 Top Selling Products

```python
df.groupBy("Description").sum("Quantity") \
  .orderBy("sum(Quantity)", ascending=False).show(5)
```

---

# 🧠 **11. Window Functions (Advanced)**

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import rank

windowSpec = Window.partitionBy("Country").orderBy(col("TotalPrice").desc())

df_ranked = df.withColumn("Rank", rank().over(windowSpec))
df_ranked.show()
```

---

# 🔗 **12. Join Operations**

### 🔹 Create Customer Dataset

```python
customers = spark.createDataFrame([
    (17850, "Regular"),
    (13047, "Premium"),
    (12583, "Regular"),
    (15100, "New")
], ["CustomerID", "Segment"])
```

### 🔹 Join

```python
df = df.join(customers, on="CustomerID", how="left")
df.show()
```

---

# 📈 **13. Correlation & Statistical Analysis**

```python
df.stat.corr("Quantity", "TotalPrice")
```

---

# 📉 **14. Outlier Detection (IQR Method)**

```python
quantiles = df.approxQuantile("TotalPrice", [0.25, 0.75], 0)
Q1, Q3 = quantiles
IQR = Q3 - Q1

df_outliers = df.filter((col("TotalPrice") < Q1 - 1.5*IQR) | 
                        (col("TotalPrice") > Q3 + 1.5*IQR))
df_outliers.show()
```

---

# 📊 **15. Pivot Table**

```python
df.groupBy("Country").pivot("Month").sum("TotalPrice").show()
```

---

# 🎨 **16. Visualization**

```python
pdf = df.toPandas()

import matplotlib.pyplot as plt
import seaborn as sns

sns.barplot(x="Country", y="TotalPrice", data=pdf)
plt.show()
```

---

# ⚡ **17. Performance Optimization**

### 🔹 Caching

```python
df.cache()
```

### 🔹 Repartition

```python
df = df.repartition(4)
```

---

# ⏱️ **18. Benchmarking**

```python
import time

start = time.time()
df.groupBy("Country").sum("TotalPrice").show()
print("Time:", time.time() - start)
```

---

# 📊 **19. Expected Insights**

* Highest revenue country
* Top selling product
* Customer segmentation trends
* Monthly sales pattern

---

# 🧪 **20. Student Tasks**

1. Find top 3 customers by spending
2. Identify least selling product
3. Perform country-wise comparison
4. Detect anomalies in pricing
5. Compare performance with and without caching

---

# 🚀 **21. Mini Project**

### Title:

**Retail Sales Analytics using PySpark**

### Deliverables:

* Code
* Insights report
* Visualization
* Benchmark results

---

# 📌 **22. Conclusion**

Advanced EDA in PySpark enables scalable analytics using distributed processing and optimization techniques.

---

# ✅ **End of Part B Advanced Experiment**
