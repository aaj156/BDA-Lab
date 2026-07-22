#!/bin/bash
echo "===== Hadoop Lab Prerequisite Check ====="
echo
echo "User: $(whoami)"
echo

echo "Java:"
java -version 2>&1 | head -n 1
echo

echo "Python:"
python3 --version
echo

echo "Hadoop:"
hadoop version | head -n 1
echo

echo "JAVA_HOME=$JAVA_HOME"
echo "HADOOP_HOME=$HADOOP_HOME"
echo

echo "JPS Processes:"
jps
echo

echo "HDFS Report:"
hdfs dfsadmin -report | head -n 20
echo

echo "Disk Space:"
df -h .
