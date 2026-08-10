# Experiment 5: Using Sqoop to Transfer Data Between Hadoop and MySQL

## Aim

To install Apache Sqoop and execute basic commands to transfer data
between a MySQL database and Hadoop HDFS.

## Prerequisites

-   Ubuntu/Linux with Hadoop installed and running
-   Java installed
-   MySQL Server installed
-   Internet connection
-   User: `hdoop`

------------------------------------------------------------------------
# Step 0: MySQL Install
## Check MySQL

``` bash
mysql --version
```

## Install MySQL (If Required)

``` bash
sudo apt update
sudo apt install mysql-server -y
sudo service mysql start
```

## Configure Root User

``` bash
sudo mysql
```

``` sql
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'password';

FLUSH PRIVILEGES;
EXIT;
```

## Login

``` bash
mysql -u root -p
```

Password:

``` text
siesgst
```

------------------------------------------------------------------------

# Step 1: Download Apache Sqoop

``` bash
cd ~/Downloads
wget https://downloads.apache.org/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
```

Verify:

``` bash
ls
```

Expected: `sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz`

------------------------------------------------------------------------

# Step 2: Extract Sqoop

``` bash
tar -xzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
```

Verify:

``` bash
ls
```

------------------------------------------------------------------------

# Step 3: Download MySQL JDBC Connector

``` bash
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.0.26.tar.gz
tar -xzf mysql-connector-j-8.0.26.tar.gz
```

Copy the JAR:

``` bash
cp mysql-connector-j-8.0.26/mysql-connector-j-8.0.26.jar \
~/sqoop-1.4.7.bin__hadoop-2.6.0/lib/
```

------------------------------------------------------------------------

# Step 4: Configure Environment Variables

Edit `.bashrc`

``` bash
nano ~/.bashrc
```

Add

``` bash
export SQOOP_HOME=$HOME/sqoop-1.4.7.bin__hadoop-2.6.0
export PATH=$PATH:$SQOOP_HOME/bin
```

Reload

``` bash
source ~/.bashrc
```

------------------------------------------------------------------------

# Step 5: Verify Installation

``` bash
sqoop version
```

Expected: Sqoop version information.

------------------------------------------------------------------------

# Step 6: Install MySQL

``` bash
sudo apt update
sudo apt install mysql-server -y
```

Login

``` bash
sudo mysql
```

Set root password

``` sql
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'password';
EXIT;
```

Reconnect

``` bash
mysql -u root -p
```

Password

    password

------------------------------------------------------------------------

# Step 7: Create Database

``` sql
CREATE DATABASE EMP;
USE EMP;
```

------------------------------------------------------------------------

# Step 8: Create Table

``` sql
CREATE TABLE emp1(
id INT PRIMARY KEY,
name VARCHAR(50),
dept VARCHAR(30),
salary INT
);
```

------------------------------------------------------------------------

# Step 9: Insert Sample Records

``` sql
INSERT INTO emp1 VALUES
(101,'Amit','IT',50000),
(102,'Neha','HR',42000),
(103,'Riya','Sales',47000);

SELECT * FROM emp1;
```

------------------------------------------------------------------------

# Step 10: Start Hadoop

``` bash
start-dfs.sh
start-yarn.sh
jps
```

Verify that NameNode, DataNode, ResourceManager and NodeManager are
running.

------------------------------------------------------------------------

# Step 11: Import MySQL Table into HDFS

``` bash
sqoop import \
--connect jdbc:mysql://localhost/EMP \
--username root \
--password password \
--table emp1 \
--target-dir /myimport \
-m 1
```

------------------------------------------------------------------------

# Step 12: Verify Imported Data

List HDFS

``` bash
hadoop fs -ls /
```

Check directory

``` bash
hadoop fs -ls /myimport
```

Display contents

``` bash
hadoop fs -cat /myimport/part-m-00000
```

Expected: Employee records stored in HDFS.

------------------------------------------------------------------------

# Expected Output

-   Sqoop installed successfully.
-   MySQL database created.
-   Employee table imported into HDFS.
-   Data visible using `hadoop fs -cat`.

------------------------------------------------------------------------

# Viva Questions

1.  What is Apache Sqoop?
2.  Why is JDBC driver required?
3.  Difference between import and export?
4.  What is `-m 1`?
5.  What is HDFS?
6.  Why is `--target-dir` used?
7.  Can Sqoop import selected columns?
8.  Which databases are supported by Sqoop?

------------------------------------------------------------------------

# Conclusion

Apache Sqoop was successfully installed and used to transfer data from a
MySQL relational database to Hadoop HDFS. The imported data was verified
using HDFS commands.
