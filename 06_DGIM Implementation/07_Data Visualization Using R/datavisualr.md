# 📊 Data Visualization using R

## 🧪 Complete Experiment Workflow (Teaching + Execution Guide)

---

## 🎯 Objective

To learn and implement data visualization in R using a structured workflow—from setup to advanced visualization and interpretation.

---

# 🔷 1. Install R and RStudio (Environment Setup)

## 🎯 Goal

Set up the programming environment required for R-based data visualization.

---

## ▶️ Step 1: Install R

* Go to: https://cran.r-project.org
* Select your OS (Windows/Linux/Mac)
* Download and install (use default settings)

---

## ▶️ Step 2: Install RStudio

* Go to: https://posit.co/download/rstudio-desktop/
* Download **RStudio Desktop (Free Version)**
* Install normally

---

## 💡 Why RStudio?

* Integrated development environment (IDE)
* Code + plots + console in one place
* Ideal for teaching and beginners

---

## ✅ Expected Output

* R and RStudio installed successfully
* RStudio opens without errors

---

# 🔷 2. Create Your First Project

## 🎯 Goal

Organize your work properly.

---

## ▶️ Execution Steps

1. Open RStudio
2. Click **File → New Project**
3. Select **New Directory → New Project**
4. Name: `DataVisualization_R`
5. Choose location → Click Create

---

## 💡 Why Important?

* Keeps scripts, data, and outputs in one place
* Avoids file path errors

---

# 🔷 3. Install Required Packages

## 🎯 Goal

Install and load required libraries for visualization.

---

## ▶️ Step 1: Install Packages (One-time)

```r
install.packages(c("ggplot2","dplyr","readr","plotly","tidyr"))
```

---

## ▶️ Step 2: Load Libraries (Every Session)

```r
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(tidyr)
```

---

## ▶️ Step 3: Verify Setup

```r
sessionInfo()
```

---

## ▶️ Mini Test

```r
ggplot(mtcars, aes(wt, mpg)) + geom_point()
```

---

## ✅ Expected Output

* Plot appears successfully

---

## ⚠️ Common Mistakes

* Not loading libraries
* Reinstalling packages repeatedly

---

# 🔷 4. Choose and Load Dataset

## 🎯 Goal

Select a meaningful dataset for visualization.

---

## 📥 Recommended Dataset

### Student Performance Dataset

https://www.kaggle.com/competitions/student-at-risk-subject-topic-risk-analysis/data

---

## ▶️ Load Dataset

```r
data <- read_csv(file.choose())
```

---

## ▶️ Verify Data

```r
head(data)
str(data)
summary(data)
```

---

## ▶️ Data Cleaning

```r
data <- na.omit(data)
data$gender <- as.factor(data$gender)
```

---

## ✅ Expected Output

* Clean dataset without missing values

---

## ⚠️ Common Mistakes

* Ignoring missing values
* Incorrect data types

---

# 🔷 5. Basic Data Exploration

## 🎯 Goal

Understand structure and characteristics of data.

---

## ▶️ Execution Steps

```r
str(data)
summary(data)
head(data)
colSums(is.na(data))
```

---

## 🔍 What to Observe

* Number of rows & columns
* Data types
* Statistical summary
* Missing values

---

## ▶️ Correlation (Advanced)

```r
cor(data[sapply(data, is.numeric)])
```

---

## ✅ Expected Output

* Clear understanding of dataset

---

# 🔷 6. Core Data Visualization (ggplot2)

## 🎯 Goal

Create basic visualizations.

---

## 🧠 Grammar of Graphics

```r
ggplot(data, aes(x, y)) + geom_*
```

---

## 📊 Scatter Plot

```r
ggplot(data, aes(x = study_time, y = marks)) +
  geom_point(color = "blue")
```

---

## 📊 Bar Chart

```r
ggplot(data, aes(x = gender)) +
  geom_bar(fill = "orange")
```

---

## 📊 Histogram

```r
ggplot(data, aes(x = marks)) +
  geom_histogram(fill = "green", bins = 10)
```

---

## 📊 Box Plot

```r
ggplot(data, aes(x = gender, y = marks)) +
  geom_boxplot(fill = "purple")
```

---

## ⚠️ Note on Line Plot

Use only for ordered/time-series data.

---

## ✅ Expected Output

* Multiple plots generated

---

# 🔷 7. Data Manipulation

## 🎯 Goal

Transform raw data into meaningful insights.

---

## ▶️ Example

```r
data %>%
  group_by(gender) %>%
  summarise(avg_marks = mean(marks))
```

---

## ▶️ More Operations

```r
data %>% filter(gender == "Male")
data %>% arrange(desc(marks))
data %>% mutate(score_ratio = marks / study_time)
```

---

## ✅ Expected Output

* Aggregated and meaningful data

---

# 🔷 8. Interactive Visualization

## 🎯 Goal

Enhance plots with interactivity.

---

## ▶️ Execution

```r
p <- ggplot(data, aes(study_time, marks)) +
  geom_point()

ggplotly(p)
```

---

## ✅ Features

* Hover values
* Zoom
* Dynamic interaction

---

# 🔷 9. Export Visualization

## 🎯 Goal

Save plots for reports.

---

## ▶️ Execution

```r
ggsave("plot.png", width = 8, height = 6, dpi = 300)
```

---

## ▶️ Check Directory

```r
getwd()
```

---

## ⚠️ Common Mistakes

* Wrong directory
* Plot not generated before saving

---

# 🔷 10. Interpretation of Results

## 🎯 Goal

Extract meaningful insights.

---

## ▶️ Ask Questions

1. What trend is visible?
2. Any outliers?
3. What conclusion can be drawn?

---

## 🧠 Example

* Study time ↑ → marks ↑
* Some students outperform (outliers)

---

# 🔷 11. Advanced Enhancements

---

## 📊 Advanced ggplot

```r
ggplot(data, aes(study_time, marks, color = gender)) +
  geom_point() +
  facet_wrap(~gender) +
  theme_minimal()
```

---

## 🌐 Shiny Dashboard

```r
install.packages("shiny")
```

---

## ⚡ Big Data Tools

* data.table
* sparklyr

---

## 🤖 Machine Learning

* Clustering
* PCA

---

## 🗺️ GIS Visualization

```r
install.packages("leaflet")
```

---

# 🔷 Final Learning Outcomes

Students will be able to:

* Install and configure R
* Load and clean datasets
* Perform data exploration
* Create multiple visualizations
* Interpret results
* Export professional outputs

---

# 🔷 Evaluation Rubric

| Criteria         | Marks |
| ---------------- | ----- |
| Data Preparation | 20    |
| Visualization    | 30    |
| Interpretation   | 30    |
| Presentation     | 20    |

---

# 🔷 Conclusion

This experiment provides a complete pipeline for transforming raw data into actionable insights using R, preparing students for real-world analytics and research tasks.

---
