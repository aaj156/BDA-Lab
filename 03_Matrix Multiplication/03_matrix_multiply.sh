#!/bin/bash

###############################################################################
# Hadoop MapReduce Matrix Multiplication Automation Script
# Author : Laboratory Manual Version 2
# Purpose: Compile, Package, Upload and Execute MatrixMultiply.java
###############################################################################

echo "====================================================="
echo " Hadoop Matrix Multiplication Automation Script"
echo "====================================================="

#-----------------------------
# Configuration
#-----------------------------

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

if [ -z "$HADOOP_HOME" ]; then
    export HADOOP_HOME=$HOME/hadoop
fi

export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

PROJECT_DIR=$HOME/hadoop_workspace/MatrixMultiplication
PACKAGE_DIR=$PROJECT_DIR/mypackage
CLASS_DIR=$PROJECT_DIR/classes
INPUT_DIR=$PROJECT_DIR/input

cd "$PROJECT_DIR" || exit 1

echo
echo "Project Directory:"
pwd

#-----------------------------
# Check Java
#-----------------------------

echo
echo "Checking Java..."

java -version

if [ $? -ne 0 ]; then
    echo "Java not found."
    exit 1
fi

#-----------------------------
# Check Hadoop
#-----------------------------

echo
echo "Checking Hadoop..."

hadoop version

if [ $? -ne 0 ]; then
    echo "Hadoop not found."
    exit 1
fi

#-----------------------------
# Check Java Source
#-----------------------------

echo
echo "Checking MatrixMultiply.java..."

if [ ! -f "$PACKAGE_DIR/MatrixMultiply.java" ]; then
    echo "ERROR:"
    echo "MatrixMultiply.java not found."
    echo
    echo "Expected location:"
    echo "$PACKAGE_DIR"
    exit 1
fi

#-----------------------------
# Clean Previous Build
#-----------------------------

echo
echo "Cleaning previous build..."

rm -rf "$CLASS_DIR"
mkdir -p "$CLASS_DIR"

rm -f MatrixMultiply.jar

#-----------------------------
# Compile
#-----------------------------

echo
echo "Compiling Java..."

javac \
-classpath "$(hadoop classpath)" \
-d "$CLASS_DIR" \
"$PACKAGE_DIR/MatrixMultiply.java"

if [ $? -ne 0 ]; then
    echo
    echo "Compilation Failed."
    exit 1
fi

echo "Compilation Successful."

#-----------------------------
# Create Jar
#-----------------------------

echo
echo "Creating JAR..."

jar -cvf MatrixMultiply.jar -C "$CLASS_DIR" .

if [ $? -ne 0 ]; then
    echo "Jar creation failed."
    exit 1
fi

echo
echo "Jar Created Successfully."

#-----------------------------
# Verify Input File
#-----------------------------

echo
echo "Checking Input..."

if [ ! -f "$INPUT_DIR/matrix.txt" ]; then

echo "matrix.txt not found."

echo

echo "Creating sample matrix.txt..."

cat <<EOF > "$INPUT_DIR/matrix.txt"
A,0,0,1
A,0,1,2
A,1,0,3
A,1,1,4
B,0,0,5
B,0,1,7
B,1,0,6
B,1,1,8
EOF

fi

#-----------------------------
# Upload to HDFS
#-----------------------------

echo
echo "Uploading input to HDFS..."

hdfs dfs -rm -r -f /matrix/input >/dev/null 2>&1
hdfs dfs -rm -r -f /matrix/output >/dev/null 2>&1

hdfs dfs -mkdir -p /matrix/input

hdfs dfs -put "$INPUT_DIR/matrix.txt" /matrix/input/

echo
echo "Input uploaded."

#-----------------------------
# Execute MapReduce Job
#-----------------------------

echo
echo "Executing Hadoop Job..."

hadoop jar MatrixMultiply.jar \
mypackage.MatrixMultiply \
/matrix/input \
/matrix/output

if [ $? -ne 0 ]; then
    echo
    echo "MapReduce Job Failed."
    exit 1
fi

#-----------------------------
# Display Output
#-----------------------------

echo
echo "======================================="
echo " MATRIX MULTIPLICATION OUTPUT"
echo "======================================="

hdfs dfs -cat /matrix/output/part-r-00000

#-----------------------------
# Useful URLs
#-----------------------------

echo
echo "---------------------------------------"
echo "NameNode UI"
echo "http://localhost:9870"
echo

echo "ResourceManager UI"
echo "http://localhost:8088"
echo

echo "Browse Output"
echo "/matrix/output"

echo "---------------------------------------"

echo
echo "Experiment Completed Successfully."
