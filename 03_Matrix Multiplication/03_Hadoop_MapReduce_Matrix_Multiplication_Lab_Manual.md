
# Hadoop MapReduce Matrix Multiplication Laboratory Manual

**Course:** Big Data Analytics / Data Engineering  
**Experiment:** Matrix Multiplication using Hadoop MapReduce

---

# 1. Aim

To implement matrix multiplication using the Hadoop MapReduce programming model and understand how a large matrix computation can be distributed across multiple machines.

---

# 2. Learning Objectives

After completing this experiment, students will be able to:

- Explain the MapReduce programming model.
- Represent matrices in Hadoop input format.
- Develop and execute a Hadoop MapReduce application.
- Understand the role of Mapper and Reducer.
- Compile Java code and create JAR files.
- Execute jobs on HDFS.
- Interpret the generated output.

---

# 3. Prerequisites

- Ubuntu/WSL
- Java 11+
- Hadoop 3.x configured
- HDFS running
- JAVA_HOME configured
- Basic knowledge of Java

---

# 4. Theory

## 4.1 Matrix Multiplication

For two matrices

A (m × n)

and

B (n × p)

the result matrix C is

(m × p).

Each element is calculated as

```
C(i,j)= Σ A(i,k) × B(k,j)
```

Example

```
A

1 2
3 4

B

5 7
6 8
```

```
C00 = 1×5 + 2×6 = 17
C01 = 1×7 + 2×8 = 23
C10 = 3×5 + 4×6 = 39
C11 = 3×7 + 4×8 = 53
```

Result

```
17 23
39 53
```

---

# 5. Why Hadoop?

Traditional multiplication is performed on a single machine.

For large matrices (millions of rows and columns):

- Huge memory requirement
- Long execution time
- Limited scalability

Hadoop distributes computation across many nodes.

---

# 6. MapReduce Workflow

```
Input Files
      │
      ▼
 Mapper
      │
Intermediate Key-Value Pairs
      │
Shuffle & Sort
      │
      ▼
 Reducer
      │
      ▼
Final Matrix
```

---

# 7. Project Directory

```text
MatrixMultiplication/
│
├── classes/
├── input/
├── output/
└── mypackage/
```

---

# 8. Input Format

Each record

```
Matrix,row,column,value
```

Example

```
A,0,1,2
```

means

- Matrix A
- Row 0
- Column 1
- Value 2

Sample input:

```text
A,0,0,1
A,0,1,2
A,1,0,3
A,1,1,4
B,0,0,5
B,0,1,7
B,1,0,6
B,1,1,8
```

---

# 9. Algorithm

1. Read each matrix element.
2. Mapper emits partial products.
3. Hadoop groups keys.
4. Reducer matches corresponding A and B values.
5. Multiply matching elements.
6. Sum products.
7. Write final matrix.

---

# 10. Mapper Explanation

The mapper:

- Reads one record
- Identifies matrix A or B
- Emits keys corresponding to output cell positions
- Sends intermediate values to reducers

Example:

Input

```
A,0,1,2
```

Mapper emits

```
Key = (0,0)
Value = A,1,2

Key = (0,1)
Value = A,1,2
```

---

# 11. Reducer Explanation

Reducer receives

```
(0,0)

A,0,1
A,1,2
B,0,5
B,1,6
```

Calculation

```
1×5 + 2×6

=

17
```

Reducer outputs

```
0,0   17
```

---

# 12. Step-by-Step Practical

## Step 1

Create folders

```bash
mkdir -p ~/hadoop_workspace/MatrixMultiplication/{classes,input,output,mypackage}
```

## Step 2

Copy Java source into

```
mypackage/MatrixMultiply.java
```

## Step 3

Create matrix.txt

## Step 4

Compile

```bash
javac -classpath $(hadoop classpath) -d classes mypackage/MatrixMultiply.java
```

## Step 5

Create JAR

```bash
jar -cvf MatrixMultiply.jar -C classes .
```

## Step 6

Upload input

```bash
hadoop fs -mkdir -p /matrix/input
hadoop fs -put input/matrix.txt /matrix/input/
```

## Step 7

Run

```bash
hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply /matrix/input /matrix/output
```

## Step 8

View output

```bash
hadoop fs -cat /matrix/output/part-r-00000
```

---

# 13. Expected Output

```
0,0 17
0,1 23
1,0 39
1,1 53
```

---

# 14. Dry Run

|Cell|Calculation|Answer|
|---|---|---|
|C00|1×5 + 2×6|17|
|C01|1×7 + 2×8|23|
|C10|3×5 + 4×6|39|
|C11|3×7 + 4×8|53|

---

# 15. Shell Script

```bash
chmod +x matrix_multiply.sh
./matrix_multiply.sh
```

This automates:

- Compilation
- JAR creation
- HDFS upload
- Execution
- Result display

---

# 16. Troubleshooting

|Problem|Solution|
|---|---|
|Output exists|Delete output folder|
|Compilation error|Check Java/Hadoop classpath|
|Class not found|Verify package name|
|Permission denied|Use chmod +x|
|HDFS not running|Start Hadoop services|

---

# 17. Viva Questions

1. What is MapReduce?
2. Why use Hadoop for matrix multiplication?
3. Explain Mapper.
4. Explain Reducer.
5. What is Shuffle and Sort?
6. Why is HDFS used?
7. What is a JAR file?
8. Why compile Java code?
9. Difference between local FS and HDFS?
10. What is the output key?

---

# 18. Assignment

1. Multiply 3×3 matrices.
2. Modify code for dynamic matrix size.
3. Measure execution time.
4. Compare sequential and Hadoop execution.
5. Add multiple reducers.

---

# 19. Course Outcomes

Students will be able to:

- Design MapReduce applications.
- Execute Hadoop jobs.
- Analyze distributed computations.
- Interpret distributed outputs.

---

# 20. Conclusion

This experiment demonstrates how Hadoop distributes matrix multiplication using the MapReduce framework. The Mapper creates intermediate key-value pairs, Hadoop performs shuffle and sort, and the Reducer computes each output element efficiently, illustrating parallel data processing on large datasets.
