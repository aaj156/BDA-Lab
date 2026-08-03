#!/bin/bash

STREAMING=$(find $HADOOP_HOME -name "*streaming*.jar" | head -1)

hdfs dfs -mkdir -p /input
hdfs dfs -put -f input.txt /input
hdfs dfs -rm -r -f /output

hadoop jar $STREAMING -files mapper.py,reducer.py -mapper mapper.py -reducer reducer.py -input /input -output /output

echo
echo "===== OUTPUT ====="
hdfs dfs -cat /output/part-00000
