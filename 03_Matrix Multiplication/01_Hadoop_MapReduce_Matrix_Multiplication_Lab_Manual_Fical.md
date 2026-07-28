
# 03. Hadoop MapReduce Matrix Multiplication Laboratory Manual 

> **Course:** Big Data Analytics / Data Engineering  
> **Experiment:** Matrix Multiplication using Hadoop MapReduce

---

# Table of Contents

1. Aim
2. Learning Objectives
3. Prerequisites
4. Hadoop Architecture
5. Verify Hadoop Services
6. Project Folder Structure
7. Step 1 – Create Project Folder
8. Step 2 – Create MatrixMultiply.java
9. Step 3 – Prepare Input File
10. Step 4 – Compile Java Program
11. Step 5 – Create JAR File
12. Step 6 – Upload Files to HDFS
13. Step 7 – Execute MapReduce Job
14. Step 8 – Observe Output
15. Viewing Results in NameNode UI
16. ResourceManager UI
17. Understanding the Java Program
18. Shell Script (Corrected Guidelines)
19. Troubleshooting
20. Viva Questions
21. Assignments

---

# 1. Aim

Implement Matrix Multiplication using the Hadoop MapReduce framework and execute it on HDFS.

---

# 2. Learning Objectives

After completing this experiment, students will be able to:

- Explain MapReduce.
- Compile Java Hadoop programs.
- Create executable JAR files.
- Execute MapReduce jobs.
- Browse HDFS through both CLI and NameNode UI.
- Monitor jobs using ResourceManager.

---

# 3. Prerequisites

- Ubuntu / WSL
- Java 11+
- Hadoop 3.x
- HDFS configured
- YARN configured
- VS Code or Nano editor

---

# 4. Hadoop Architecture

```
User
 │
 ▼
HDFS (NameNode + DataNode)
 │
 ▼
MapReduce
 │
 ▼
YARN
 │
 ├── ResourceManager
 └── NodeManager
```

---

# 5. Verify Hadoop Services

```
jps
```

Expected

```
NameNode
DataNode
SecondaryNameNode
ResourceManager
NodeManager
```

Check HDFS

```bash
hdfs dfs -ls /
```

Open browser

NameNode

```
http://localhost:9870
```

ResourceManager

```
http://localhost:8088
```

---

# 6. Project Folder Structure

```
~/hadoop_workspace/

└── MatrixMultiplication/
    ├── classes/
    ├── input/
    ├── output/
    ├── mypackage/
    └── MatrixMultiply.jar
```

---

# 7. Step 1 – Create Project Folder

```bash
mkdir -p ~/hadoop_workspace/MatrixMultiplication/{classes,input,output,mypackage}
cd ~/hadoop_workspace/MatrixMultiplication
```

Verify

```bash
tree
```

---

# 8. Step 2 – Create MatrixMultiply.java

## Option A (Faculty Provided)

Copy **MatrixMultiply.java** into

```
~/hadoop_workspace/MatrixMultiplication/mypackage/
```

## Option B (Create Yourself)

```bash
cd ~/hadoop_workspace/MatrixMultiplication/mypackage
nano MatrixMultiply.java
```

Paste the complete Java program supplied in the lab.

Save

- Ctrl+O
- Enter
- Ctrl+X

Verify

```bash
ls
```

Output

```
MatrixMultiply.java
```

The first line **must** be

```java
package mypackage;
```

---

# 9. Step 3 – Prepare Input File

Go to input folder

```bash
cd ~/hadoop_workspace/MatrixMultiplication/input
nano matrix.txt
```

Paste

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

Verify

```bash
cat matrix.txt
```

---

# 10. Step 4 – Compile Java Program

```bash
cd ~/hadoop_workspace/MatrixMultiplication

javac -classpath "$(hadoop classpath)" -d classes mypackage/MatrixMultiply.java
```

Compiled classes appear inside

```
classes/mypackage/
```

---

# 11. Step 5 – Create JAR File

```bash
jar -cvf MatrixMultiply.jar -C classes .
```

The JAR file is created in the project root.

```
MatrixMultiplication/
    MatrixMultiply.jar
```

Verify

```bash
ls
```

---

# 12. Step 6 – Upload Input to HDFS

Create HDFS directory

```bash
hdfs dfs -mkdir -p /matrix/input
```

Upload

```bash
hdfs dfs -put -f input/matrix.txt /matrix/input/
```

Verify

```bash
hdfs dfs -ls /matrix/input
```

---

# 13. Step 7 – Execute MapReduce Job

Remove previous output

```bash
hdfs dfs -rm -r -f /matrix/output
```

Run

```bash
hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply /matrix/input /matrix/output
```

---

# 14. Step 8 – Observe Output

CLI

```bash
hdfs dfs -cat /matrix/output/part-r-00000
```

Expected

```
0,0 17
0,1 23
1,0 39
1,1 53
```

---

# 15. Observe Output Using NameNode

Open

```
http://localhost:9870
```

Navigate

Utilities → Browse the File System

Open

```
/matrix/output/
```

Click

```
part-r-00000
```

---

# 16. Observe Job Using ResourceManager

Open

```
http://localhost:8088
```

Students can monitor

- Running Applications
- Finished Applications
- Memory Usage
- Containers
- Application ID

---

# 17. Understanding MatrixMultiply.java

The program contains:

- Mapper
- Reducer
- Driver (main)

Mapper generates intermediate key-value pairs.

Reducer multiplies matching values and computes each output element.

Driver configures and submits the Hadoop job.

---

# 18. Corrected Shell Script Guidelines

The shell script should:

- Verify Java installation.
- Verify Hadoop installation.
- Check NameNode and ResourceManager.
- Verify MatrixMultiply.java exists.
- Compile source.
- Create MatrixMultiply.jar.
- Upload matrix.txt to HDFS.
- Execute MapReduce.
- Display output.

Do **not** create placeholder Java files inside the script. The Java source should already exist in `mypackage/MatrixMultiply.java`.

---

# 19. Common Errors

| Error | Solution |
|-------|----------|
| Output directory exists | Delete `/matrix/output` |
| ClassNotFoundException | Verify package name |
| JAVA_HOME not set | Export JAVA_HOME |
| hdfs command not found | Source Hadoop environment |
| Permission denied | chmod +x script |
| NameNode not running | Start HDFS |
| ResourceManager not running | Start YARN |

---

# 20. Viva Questions

1. What is MapReduce?
2. Explain Mapper.
3. Explain Reducer.
4. What is HDFS?
5. What is YARN?
6. Why create a JAR file?
7. What is `part-r-00000`?
8. Why must the output directory not exist?
9. Difference between local filesystem and HDFS?
10. How do you monitor a running job?

---

# 21. Assignments

1. Implement 3×3 matrix multiplication.
2. Accept matrix dimensions as input.
3. Compare sequential vs Hadoop execution time.
4. Implement matrix addition using MapReduce.
5. Implement sparse matrix multiplication.

---

# End of Manual
