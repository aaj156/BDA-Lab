# ==========================================
# 📊 Data Visualization Complete Experiment
# ==========================================

# 🔷 1. Install Packages (Run once)
packages <- c("ggplot2","dplyr","readr","plotly","tidyr")

installed <- rownames(installed.packages())
for(p in packages){
  if(!(p %in% installed)){
    install.packages(p)
  }
}

# 🔷 2. Load Libraries
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(tidyr)

# 🔷 3. Load Dataset
# Option 1: Choose your CSV file manually
# data <- read_csv(file.choose())

# Option 2: Use built-in dataset (for testing)
data <- mtcars

# 🔷 4. Prepare Dataset (for consistency)
data$mpg <- as.numeric(data$mpg)
data$wt <- as.numeric(data$wt)

# Convert cyl to factor (categorical)
data$cyl <- as.factor(data$cyl)

# 🔷 5. Basic Exploration
cat("===== DATA SUMMARY =====\n")
print(head(data))
print(str(data))
print(summary(data))

# Check missing values
cat("Missing Values:\n")
print(colSums(is.na(data)))

# 🔷 6. Basic Visualizations

# Scatter Plot
p1 <- ggplot(data, aes(x = wt, y = mpg)) +
  geom_point(color = "blue") +
  ggtitle("Scatter Plot: Weight vs MPG")

print(p1)

# Bar Chart
p2 <- ggplot(data, aes(x = cyl)) +
  geom_bar(fill = "orange") +
  ggtitle("Bar Chart: Cylinder Count")

print(p2)

# Histogram
p3 <- ggplot(data, aes(x = mpg)) +
  geom_histogram(fill = "green", bins = 10) +
  ggtitle("Histogram: MPG Distribution")

print(p3)

# Box Plot
p4 <- ggplot(data, aes(x = cyl, y = mpg)) +
  geom_boxplot(fill = "purple") +
  ggtitle("Boxplot: MPG by Cylinder")

print(p4)

# 🔷 7. Data Manipulation

cat("\n===== DATA MANIPULATION =====\n")

summary_data <- data %>%
  group_by(cyl) %>%
  summarise(avg_mpg = mean(mpg))

print(summary_data)

# Filter example
filtered_data <- data %>% filter(mpg > 20)
print(filtered_data)

# 🔷 8. Correlation Matrix
cat("\n===== CORRELATION =====\n")
numeric_data <- data[sapply(data, is.numeric)]
print(cor(numeric_data))

# 🔷 9. Interactive Plot
p_interactive <- ggplot(data, aes(wt, mpg)) +
  geom_point()

ggplotly(p_interactive)

# 🔷 10. Save Plot
ggsave("scatter_plot.png", plot = p1, width = 8, height = 6, dpi = 300)

cat("\nPlot saved as scatter_plot.png in working directory\n")
print(getwd())

# 🔷 11. Interpretation (Printed Output)
cat("\n===== INSIGHTS =====\n")
cat("1. As weight increases, MPG generally decreases.\n")
cat("2. Cars with fewer cylinders tend to have higher MPG.\n")
cat("3. Some outliers exist with unusually high MPG.\n")

# 🔷 END
cat("\n✅ Experiment Completed Successfully!\n")
