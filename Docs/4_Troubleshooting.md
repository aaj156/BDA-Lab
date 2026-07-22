# Troubleshooting

| Problem | Solution |
|---------|----------|
| start-dfs.sh not found | Source Hadoop environment or add Hadoop to PATH |
| NameNode not running | Format (first time) then restart HDFS |
| Permission denied | chmod +x mapper.py reducer.py |
| Output directory exists | hdfs dfs -rm -r /output |
| Streaming jar not found | find $HADOOP_HOME -name "*streaming*.jar" |
| Python not found | Install Python3 and verify PATH |
| No DataNode | Check jps and restart HDFS |
| Input not found | Upload using hdfs dfs -put |
