# Hadoop MapReduce Matrix Multiplication

A laboratory experiment demonstrating **Matrix Multiplication using Hadoop MapReduce**. This project is intended for students learning Big Data Analytics and Data Engineering.

---

## Project Structure

```text
MatrixMultiplication/
├── classes/                 # Compiled Java classes
├── input/                   # Local input files
│   └── matrix.txt
├── output/                  # Local output (optional)
├── mypackage/
│   └── MatrixMultiply.java  # Java source code
├── MatrixMultiply.jar       # Generated application JAR
├── matrix_multiply.sh       # Automation script
└── README.md
```

---

## Software Requirements

- Ubuntu / WSL
- Java 11 or later
- Hadoop 3.x
- HDFS and YARN configured
- Terminal (or VS Code)

---

## Input Format

The program expects a single file named `matrix.txt` with records in the format:

```text
Matrix,row,column,value
```

Example:

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

## Build Instructions

Compile the Java program:

```bash
javac -classpath "$(hadoop classpath)" -d classes mypackage/MatrixMultiply.java
```

Create the JAR:

```bash
jar -cvf MatrixMultiply.jar -C classes .
```

---

## Run the Program

Upload the input file:

```bash
hdfs dfs -mkdir -p /matrix/input
hdfs dfs -put -f input/matrix.txt /matrix/input/
```

Execute the MapReduce job:

```bash
hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply /matrix/input /matrix/output
```

Display the result:

```bash
hdfs dfs -cat /matrix/output/part-r-00000
```

---

## Automation Script

Instead of running each command manually:

```bash
chmod +x matrix_multiply.sh
./matrix_multiply.sh
```

The script will:

- Verify Java and Hadoop installation
- Compile the Java source
- Create the application JAR
- Upload the input to HDFS
- Execute the MapReduce job
- Display the final output

---

## Web Interfaces

### NameNode

```
http://localhost:9870
```

Browse:

```
Utilities → Browse the File System
```

### ResourceManager

```
http://localhost:8088
```

Use it to monitor running and completed MapReduce jobs.

---

## Expected Output

```text
0,0    17
0,1    23
1,0    39
1,1    53
```

---

## Troubleshooting

- Ensure `JAVA_HOME` is configured.
- Verify Hadoop services using `jps`.
- Remove an existing HDFS output directory before rerunning:
  ```bash
  hdfs dfs -rm -r -f /matrix/output
  ```
- Ensure `MatrixMultiply.java` is located in `mypackage/`.
- Ensure `matrix.txt` is located in the `input/` folder.

---

## Learning Outcomes

After completing this experiment, students should be able to:

- Explain the MapReduce programming model.
- Build and package a Hadoop application.
- Execute MapReduce jobs on HDFS.
- Monitor jobs using the Hadoop web interfaces.
- Interpret matrix multiplication results.

---

## Authors

Prepared for **Big Data Analytics / Data Engineering Laboratory**.
Suitable for BE/B.Tech practical sessions using Hadoop MapReduce.
