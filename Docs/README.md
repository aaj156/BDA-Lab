# Hadoop MapReduce Lab Files

This folder contains the source files required to perform the **Word Count** experiment using **Hadoop Streaming** and **Python**.

## Folder Structure

```
WordCountPython/
├── README.md
├── mapper.py
├── reducer.py
├── input.txt
└── check_prerequisites.sh
```

## Files

### README.md
Overview of the experiment and folder contents.

### mapper.py
Reads input from standard input and emits:
```
<word>    1
```

### reducer.py
Aggregates all values for each word and outputs:
```
<word>    total_count
```

### input.txt
Sample input dataset used for testing.

### check_prerequisites.sh
Checks Java, Python, Hadoop, HDFS and running Hadoop daemons.

## Execution Order

1. Run `check_prerequisites.sh`
2. Start HDFS
3. Test mapper and reducer locally
4. Upload `input.txt` to HDFS
5. Execute Hadoop Streaming
6. View results

Happy Learning!
