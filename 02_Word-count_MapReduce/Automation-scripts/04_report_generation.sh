#!/bin/bash
REPORT=Lab_Report_$(date +%Y%m%d_%H%M%S).txt

echo "Hadoop MapReduce Experiment Report" > $REPORT
echo "=================================" >> $REPORT
echo "Date: $(date)" >> $REPORT
echo "" >> $REPORT

echo "User:" >> $REPORT
whoami >> $REPORT

echo "" >> $REPORT
echo "Java:" >> $REPORT
java -version 2>&1 | head -1 >> $REPORT

echo "" >> $REPORT
echo "Python:" >> $REPORT
python3 --version >> $REPORT

echo "" >> $REPORT
echo "Hadoop:" >> $REPORT
hadoop version | head -1 >> $REPORT

echo "" >> $REPORT
echo "Processes:" >> $REPORT
jps >> $REPORT

echo "" >> $REPORT
echo "MapReduce Output:" >> $REPORT
hdfs dfs -cat /output/part-00000 >> $REPORT 2>/dev/null

echo "" >> $REPORT
echo "Expected Output:" >> $REPORT
cat expected_output.txt >> $REPORT

echo "" >> $REPORT
echo "Assignment Status: Completed / Pending (Student fills manually)" >> $REPORT

echo "Report saved as $REPORT"
