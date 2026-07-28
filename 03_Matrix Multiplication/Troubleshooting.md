# Troubleshooting Guide
## Hadoop MapReduce Matrix Multiplication Laboratory

This document provides common errors encountered while performing the Hadoop MapReduce Matrix Multiplication experiment and their solutions.

---

# 1. JAVA_HOME is not set

## Error

```text
Error: JAVA_HOME is not set.
```

## Cause

Java environment variable is not configured.

## Solution

```bash
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

Verify

```bash
java -version
```

---

# 2. Hadoop Command Not Found

## Error

```text
hadoop: command not found
```

## Cause

Hadoop is not installed or PATH is incorrect.

## Solution

```bash
export HADOOP_HOME=$HOME/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
```

Verify

```bash
hadoop version
```

---

# 3. HDFS Command Not Found

## Error

```text
hdfs: command not found
```

## Solution

Check Hadoop installation and PATH.

---

# 4. NameNode is Not Running

## Error

```text
Connection refused
```

## Solution

Start HDFS

```bash
start-dfs.sh
```

Verify

```bash
jps
```

Expected

```text
NameNode
DataNode
SecondaryNameNode
```

---

# 5. ResourceManager is Not Running

Start YARN

```bash
start-yarn.sh
```

Verify

```bash
jps
```

Expected

```text
ResourceManager
NodeManager
```

---

# 6. MatrixMultiply.java Not Found

## Error

```text
MatrixMultiply.java not found
```

## Solution

Place the file in

```text
~/hadoop_workspace/MatrixMultiplication/mypackage/
```

---

# 7. Package Does Not Exist

## Error

```text
package org.apache.hadoop.mapreduce does not exist
```

## Cause

Classpath is missing.

## Solution

Compile using

```bash
javac -classpath "$(hadoop classpath)" -d classes mypackage/MatrixMultiply.java
```

---

# 8. Compilation Failed

Check

- Java version
- Hadoop classpath
- Package name
- Missing semicolons
- Missing braces

---

# 9. Could Not Find Main Class

## Error

```text
Could not find or load main class
```

## Solution

Verify

```java
package mypackage;
```

and run

```bash
hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply
```

---

# 10. JAR Not Found

## Error

```text
Unable to access jarfile MatrixMultiply.jar
```

## Solution

Create the JAR

```bash
jar -cvf MatrixMultiply.jar -C classes .
```

---

# 11. Output Directory Already Exists

## Error

```text
Output directory already exists
```

## Solution

```bash
hdfs dfs -rm -r -f /matrix/output
```

---

# 12. Input File Missing

Verify

```bash
ls input
```

Expected

```text
matrix.txt
```

---

# 13. File Already Exists in HDFS

Use

```bash
hdfs dfs -put -f input/matrix.txt /matrix/input/
```

or

```bash
hdfs dfs -rm /matrix/input/matrix.txt
```

---

# 14. Permission Denied

## Error

```text
Permission denied
```

## Solution

```bash
chmod +x matrix_multiply.sh
```

---

# 15. HDFS Safe Mode

## Error

```text
Cannot delete because NameNode is in SafeMode
```

## Solution

```bash
hdfs dfsadmin -safemode leave
```

---

# 16. Verify Hadoop Services

```bash
jps
```

Expected

```text
NameNode
DataNode
SecondaryNameNode
ResourceManager
NodeManager
```

---

# 17. Verify HDFS

```bash
hdfs dfs -ls /
```

---

# 18. Verify Input Upload

```bash
hdfs dfs -ls /matrix/input
```

---

# 19. Verify Output

```bash
hdfs dfs -ls /matrix/output
```

Expected

```text
_SUCCESS
part-r-00000
```

---

# 20. View Output

```bash
hdfs dfs -cat /matrix/output/part-r-00000
```

---

# 21. NameNode Web UI

Open

http://localhost:9870

Navigate

Utilities → Browse the File System

---

# 22. ResourceManager Web UI

Open

http://localhost:8088

Monitor

- Running jobs
- Finished jobs
- Memory
- Containers

---

# 23. Job History Server

If configured

http://localhost:19888

---

# 24. Clean Project

```bash
rm -rf classes
rm -f MatrixMultiply.jar
```

Do not delete your Java source file.

---

# 25. Rebuild Project

```bash
javac -classpath "$(hadoop classpath)" -d classes mypackage/MatrixMultiply.java

jar -cvf MatrixMultiply.jar -C classes .

hdfs dfs -rm -r -f /matrix/output

hadoop jar MatrixMultiply.jar mypackage.MatrixMultiply /matrix/input /matrix/output
```

---

# Quick Checklist Before Running

- Java installed
- JAVA_HOME configured
- Hadoop installed
- HDFS running
- YARN running
- MatrixMultiply.java present
- matrix.txt present
- JAR created
- Input uploaded to HDFS
- Previous output removed

---

# Useful Commands

```bash
jps

hadoop version

hdfs dfs -ls /

hdfs dfs -cat /matrix/output/part-r-00000

hdfs dfsadmin -report

start-dfs.sh

start-yarn.sh
```

---

# Summary

Most Hadoop execution problems are caused by:

1. Hadoop services not running.
2. Incorrect classpath.
3. Missing Java source or JAR file.
4. Existing HDFS output directory.
5. Incorrect package name.

Following this guide should resolve the majority of issues encountered during the Matrix Multiplication laboratory experiment.
