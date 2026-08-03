# Part 1 – Environment Setup and Hadoop Startup

## 1. Login

Login using the laboratory user.

```bash
ssh bdalab@<server-ip>
```

or log in locally as **bdalab**.

Verify:

```bash
whoami
```

Expected:

```text
bdalab
```

---

## 2. Verify Prerequisites

Run:

```bash
chmod +x check_prerequisites.sh
./check_prerequisites.sh
```

The script verifies:

- Java
- Python 3
- Hadoop
- JAVA_HOME
- HADOOP_HOME
- JPS processes
- HDFS availability

---

## 3. Start Hadoop

```bash
start-dfs.sh
```

Verify:

```bash
jps
```

Expected:

- NameNode
- DataNode
- SecondaryNameNode

If any service is missing:

```bash
stop-dfs.sh
start-dfs.sh
```

Check HDFS:

```bash
hdfs dfsadmin -report
```

---

## 4. Create Working Folder

```bash
mkdir -p ~/WordCountPython
cd ~/WordCountPython
```

---

## 5. Create Input File

```bash
nano input.txt
```

Example:

```text
Hello Hadoop
Hello Python
Hello MapReduce
Python Hadoop
Big Data Hadoop
```
