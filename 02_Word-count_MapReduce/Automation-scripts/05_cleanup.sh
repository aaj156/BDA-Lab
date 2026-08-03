#!/bin/bash
echo "Cleaning HDFS..."
hdfs dfs -rm -r -f /input >/dev/null 2>&1
hdfs dfs -rm -r -f /output >/dev/null 2>&1

echo "Cleaning local files..."
rm -f mapper.out reducer.out report.txt

echo "Done."
