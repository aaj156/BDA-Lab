# Hadoop MapReduce Theory

# Objective
Implement Word Count using Hadoop Streaming and Python.

# Hadoop Architecture

```text
                Client
                  |
                  v
            +-------------+
            |  NameNode   |
            +-------------+
             Metadata Only
                  |
      --------------------------
      |                        |
+-------------+         +-------------+
| DataNode 1  |         | DataNode 2  |
+-------------+         +-------------+
| Block A     |         | Block B     |
+-------------+         +-------------+
```

# MapReduce Architecture

```text
Input File
    |
    v
 HDFS Blocks
    |
    v
+-----------+
|  Mapper   |
+-----------+
    |
<word,1>
    |
Shuffle & Sort
    |
    v
+-----------+
| Reducer   |
+-----------+
    |
Word Counts
    |
    v
HDFS Output
```

## Data Flow
1. Input file stored locally.
2. Uploaded to HDFS.
3. NameNode stores metadata.
4. DataNodes store blocks.
5. Mapper processes local blocks.
6. Hadoop performs shuffle and sort.
7. Reducer aggregates counts.
8. Output written back to HDFS.

## Hadoop Streaming
Allows Mapper and Reducer to be written in Python, Shell, Perl, Ruby or any language supporting standard input/output.

## Mapper
Reads each line and emits:
<word,1>

## Reducer
Receives sorted keys and sums values.

## Advantages
- Parallel processing
- Fault tolerant
- Scalable
- Data locality
- High throughput
