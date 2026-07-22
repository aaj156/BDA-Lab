# Part 3 – Hadoop Execution, Output and Troubleshooting

## 1. Upload to HDFS

```bash
hdfs dfs -mkdir -p /input
hdfs dfs -put -f input.txt /input
hdfs dfs -ls /input
```

---

## 2. Run Hadoop Streaming

Locate the Streaming JAR:

```bash
find $HADOOP_HOME -name "*streaming*.jar"
```

Run:

```bash
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
-files mapper.py,reducer.py \
-mapper mapper.py \
-reducer reducer.py \
-input /input \
-output /output
```

If output exists:

```bash
hdfs dfs -rm -r /output
```

---

## 3. View Output

```bash
hdfs dfs -ls /output
hdfs dfs -cat /output/part-00000
```

---

## 4. Data Flow

Local Machine (DataNode Host)
→ Upload to HDFS
→ NameNode stores metadata
→ DataNode stores file blocks
→ Mapper executes near data
→ Shuffle & Sort
→ Reducer aggregates counts
→ Output stored in HDFS

---

## 5. Cleanup

```bash
hdfs dfs -rm -r /input
hdfs dfs -rm -r /output
```

---

## 6. Common Errors

- Output directory already exists → `hdfs dfs -rm -r /output`
- Permission denied → `chmod +x mapper.py reducer.py`
- Streaming JAR not found → locate using `find`
- NameNode/DataNode missing → restart HDFS

---

## 7. Viva Questions

1. What is Hadoop Streaming?
2. Difference between NameNode and DataNode?
3. Role of Mapper?
4. Role of Reducer?
5. What is Shuffle and Sort?
6. Why should output directory not exist?
