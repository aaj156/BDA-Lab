# Part 2 – Python MapReduce Program Development

## 1. Create mapper.py

```python
#!/usr/bin/env python3
import sys

for line in sys.stdin:
    for word in line.strip().split():
        print(f"{word}\t1")
```

Make executable:

```bash
chmod +x mapper.py
```

---

## 2. Create reducer.py

```python
#!/usr/bin/env python3
import sys

current_word=None
current_count=0

for line in sys.stdin:
    word,count=line.strip().split("\t")
    count=int(count)

    if current_word==word:
        current_count+=count
    else:
        if current_word:
            print(f"{current_word}\t{current_count}")
        current_word=word
        current_count=count

if current_word:
    print(f"{current_word}\t{current_count}")
```

```bash
chmod +x reducer.py
```

---

## 3. Local Testing

Mapper:

```bash
cat input.txt | python3 mapper.py
```

Complete pipeline:

```bash
cat input.txt | python3 mapper.py | sort | python3 reducer.py
```

Expected:

```text
Big 1
Data 1
Hadoop 3
Hello 3
MapReduce 1
Python 2
```
# DataNode Not Starting – Debugging Guide

If the **DataNode** process is not visible after executing the `jps` command, follow the steps below to identify and resolve the issue.

---

# Step 1: Verify Running Hadoop Processes

Check the currently running Hadoop daemons.

```bash
jps
```

### Expected Output

```text
NameNode
DataNode
SecondaryNameNode
Jps
```

### Example Problem

```text
NameNode
SecondaryNameNode
Jps
```

If **DataNode** is missing, continue with the following troubleshooting steps.

---

# Step 2: Check HDFS Cluster Status

Display the HDFS cluster report.

```bash
hdfs dfsadmin -report
```

### Expected Output

```text
Configured Capacity: ...
Present Capacity: ...
DFS Remaining: ...
DFS Used: ...
Live datanodes (1)
```

### Problem Indication

If the report displays

```text
Live datanodes (0)
```

the DataNode has not started or failed to register with the NameNode.

---

# Step 3: Start the DataNode Manually

Start only the DataNode daemon.

```bash
hdfs --daemon start datanode
```

Verify that it is running.

```bash
jps
```

If the DataNode is still missing, continue with the next steps.

---

# Step 4: Verify HDFS Storage Directories

Open the Hadoop HDFS configuration file.

```bash
cat $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```

Verify that the following properties are correctly configured.

```xml
<property>
    <name>dfs.namenode.name.dir</name>
    <value>file:///home/bdalab/hadoopdata/hdfs/namenode</value>
</property>

<property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///home/bdalab/hadoopdata/hdfs/datanode</value>
</property>
```

> **Note:** Replace `/home/bdalab/` with your own home directory if you are using a different username.

---

# Step 5: Verify Storage Directories Exist

Check whether the NameNode and DataNode directories exist.

```bash
ls -ld ~/hadoopdata/hdfs/namenode
```

```bash
ls -ld ~/hadoopdata/hdfs/datanode
```

### If the DataNode directory does not exist

Create it using

```bash
mkdir -p ~/hadoopdata/hdfs/datanode
```

Verify again

```bash
ls -ld ~/hadoopdata/hdfs/datanode
```

---

# Step 6: Verify Directory Permissions

Check the permissions of the Hadoop storage directories.

```bash
ls -ld ~/hadoopdata
```

```bash
ls -ld ~/hadoopdata/hdfs
```

```bash
ls -ld ~/hadoopdata/hdfs/datanode
```

### Correct the Permissions

Grant read, write and execute permissions.

```bash
chmod -R 755 ~/hadoopdata
```

Verify ownership.

```bash
ls -ld ~/hadoopdata
```

If required, change the ownership.

```bash
chown -R $USER:$USER ~/hadoopdata
```

---

# Step 7: Restart the DataNode

After correcting the directory structure and permissions, start the DataNode again.

```bash
hdfs --daemon start datanode
```

Verify the running processes.

```bash
jps
```

Expected output

```text
NameNode
DataNode
SecondaryNameNode
Jps
```

---

# Step 8: Verify DataNode Registration

Display the HDFS report again.

```bash
hdfs dfsadmin -report
```

Expected output

```text
Live datanodes (1)

Hostname: localhost

Configured Capacity: ...

DFS Used: ...

DFS Remaining: ...
```

---

# Troubleshooting Summary

| Problem | Possible Cause | Recommended Solution |
|----------|----------------|----------------------|
| DataNode missing in `jps` | DataNode daemon not started | Start using `hdfs --daemon start datanode` |
| `Live datanodes (0)` | DataNode not registered | Check DataNode configuration and restart |
| Missing DataNode directory | Incorrect storage path | Create the directory using `mkdir -p` |
| Permission denied | Incorrect ownership or permissions | Use `chmod` and `chown` |
| Incorrect HDFS path | Wrong `dfs.datanode.data.dir` | Update `hdfs-site.xml` |
| DataNode still fails | Check DataNode logs | Inspect the log file under `$HADOOP_HOME/logs/` |

---

# Verification Checklist

- ✅ NameNode is running (`jps`)
- ✅ DataNode is running (`jps`)
- ✅ `Live datanodes (1)` displayed in `hdfs dfsadmin -report`
- ✅ Storage directories exist
- ✅ Directory permissions are correct
- ✅ DataNode successfully registers with the NameNode
