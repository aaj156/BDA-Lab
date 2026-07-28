
# Hadoop MapReduce Matrix Multiplication – Student Guide

## Objective
In this experiment, you will implement Matrix Multiplication using Hadoop MapReduce.

The provided files include:
- Java MapReduce program (`MatrixMultiply.java`)
- Sample matrix input files
- Shell script for compilation and execution

---

# Step 1: Create the Project Folder

```bash
mkdir -p ~/hadoop_workspace/MatrixMultiplication/{classes,input,output,mypackage}
cd ~/hadoop_workspace/MatrixMultiplication
```

Folder structure:

```
MatrixMultiplication/
├── classes/
├── input/
├── output/
└── mypackage/
```

---

# Step 2: Add the Java Program

Save the provided Java source as:

```
mypackage/MatrixMultiply.java
```

The program contains:

- Mapper
- Reducer
- Driver (main method)

The mapper emits partial matrix values while the reducer computes each output cell.

---

# Step 3: Prepare Input Data

Create a file:

```bash
nano input/matrix.txt
```

Paste:

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

This represents

Matrix A

```
1 2
3 4
```

Matrix B

```
5 7
6 8
```

---

# Step 4: Understand the Input Format

Each record has four fields.

```
MatrixName,row,column,value
```

Example

```
A,0,1,2
```

means

- Matrix = A
- Row = 0
- Column = 1
- Value = 2

---

# Step 5: Compile the Program

```bash
javac -classpath $(hadoop classpath) -d classes mypackage/MatrixMultiply.java
```

If compilation succeeds, class files are generated inside `classes/`.

---

# Step 6: Create the JAR

```bash
jar -cvf MatrixMultiply.jar -C classes .
```

---

# Step 7: Upload Input to HDFS

```bash
hadoop fs -mkdir -p /matrix/input
hadoop fs -put input/matrix.txt /matrix/input/
```

If rerunning:

```bash
hadoop fs -rm -r /matrix/output
```

---

# Step 8: Execute the MapReduce Job

```bash
hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply /matrix/input /matrix/output
```

---

# Step 9: View the Result

```bash
hadoop fs -cat /matrix/output/part-r-00000
```

Expected result:

```
0,0    17
0,1    23
1,0    39
1,1    53
```

---

# Step 10: Verify Manually

```
1×5 + 2×6 = 17
1×7 + 2×8 = 23
3×5 + 4×6 = 39
3×7 + 4×8 = 53
```

Output Matrix

```
17 23
39 53
```

---

# Optional Automation

A shell script can automate:

- Environment setup
- Compilation
- JAR creation
- HDFS upload
- Job execution
- Displaying results

Typical workflow:

```bash
chmod +x matrix_multiply.sh
./matrix_multiply.sh
```

---

# Common Errors

| Problem | Solution |
|---------|----------|
| Class not found | Verify package name and JAR creation |
| Output already exists | Delete output folder from HDFS |
| Compilation errors | Check Hadoop classpath |
| Java version mismatch | Use the configured Java version |
| HDFS not running | Start Hadoop daemons |

---

# Learning Outcomes

After completing this experiment, students should be able to:

- Understand Hadoop MapReduce workflow.
- Represent matrices in Hadoop input format.
- Compile Java MapReduce programs.
- Package applications into JAR files.
- Execute Hadoop jobs.
- Interpret matrix multiplication output.

Happy Learning!
