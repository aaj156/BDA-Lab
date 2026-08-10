# Experiment 5

# Weather Data Ingestion Pipeline using Open API, Python ETL, MySQL, Sqoop, HDFS and Hive (WSL)

## Section 1: Introduction, Problem Statement & Learning Outcomes

### Aim

To implement an end-to-end data ingestion pipeline that collects weather
data from an Open API, stores it in MySQL using Python, imports it into
Hadoop using Sqoop, and performs analytics using Hive.

### Introduction

Modern organizations continuously collect structured data from external
services such as weather APIs, IoT devices, banking applications, and
e-commerce platforms. While these systems use relational databases for
operational workloads, Hadoop is used for large-scale analytics. Apache
Sqoop acts as a bridge between relational databases and the Hadoop
ecosystem.

### Problem Statement

Develop a weather analytics pipeline that: 1. Collects weather
information from the Open-Meteo API. 2. Stores the data in MySQL. 3.
Imports the data into Hadoop HDFS using Sqoop. 4. Imports the HDFS data
into Hive. 5. Performs SQL analytics using Hive.

### Learning Outcomes

After completing this experiment students will be able to: - Consume
REST APIs using Python. - Parse JSON responses. - Store API data in
MySQL. - Explain why Sqoop requires a relational database. - Import
relational data into HDFS. - Perform Hive-based analytics. - Verify data
integrity throughout the ETL pipeline.

------------------------------------------------------------------------

# Section 2: Case Study & System Architecture

## Case Study

A weather monitoring organization wants to collect weather information
from 20 Indian cities. Instead of analysing data directly from the API,
it stores the information in MySQL. Apache Sqoop is then used to
transfer the data into Hadoop for large-scale analytics.

### Dataset Strategy

-   Weather Source: Open-Meteo API
-   Cities: 20 Indian Cities
-   Runs: 50
-   Expected Records: 20 × 50 = **1000 Records**

### System Architecture

``` text
Open-Meteo API
      │
HTTP GET Request
      │
      ▼
Python ETL
(Extract → Transform → Load)
      │
INSERT INTO weather
      ▼
MySQL Database
      │
Sqoop Import
      ▼
HDFS
      │
Hive Import
      ▼
Hive Analytics
```

### Why MySQL?

Sqoop can communicate only with relational databases through JDBC. It
cannot directly read JSON from a REST API. Therefore Python acts as the
ETL layer that converts JSON into SQL INSERT operations.

------------------------------------------------------------------------

# Section 3: Software Requirements & Environment Verification

## Software

  Component     Version
  ------------- ---------
  Ubuntu WSL2   24.04
  Java          11+
  Hadoop        3.3.x
  Hive          3.x
  Sqoop         1.4.7
  Python        3.x
  MySQL         8.x

## Verify Installation

``` bash
java -version
python3 --version
pip3 --version
hadoop version
hive --version
sqoop version
mysql --version
```

Expected: Every command should display its version without errors.

Start Hadoop

``` bash
start-dfs.sh
start-yarn.sh
jps
```

Expected processes:

-   NameNode
-   DataNode
-   ResourceManager
-   NodeManager

------------------------------------------------------------------------

# Section 4: MySQL Installation & Database Setup

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

## Create Database

``` sql
CREATE DATABASE weatherdb;
USE weatherdb;
```

## Create Table

``` sql
CREATE TABLE weather(
id INT AUTO_INCREMENT PRIMARY KEY,
city VARCHAR(50),
temperature FLOAT,
humidity INT,
wind_speed FLOAT,
record_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Verify

``` sql
DESC weather;
```

------------------------------------------------------------------------

# Section 5: Python ETL Development

## Install Required Packages

``` bash
sudo apt install python3-pip -y
pip3 install requests
pip3 install mysql-connector-python
```

Create Project

``` bash
mkdir WeatherPipeline
cd WeatherPipeline
nano weather_etl.py
```

## Complete Python ETL Code

``` python
import requests
import mysql.connector
import time

cities=[
("Mumbai",19.0760,72.8777),
("Delhi",28.6139,77.2090),
("Pune",18.5204,73.8567),
("Bengaluru",12.9716,77.5946),
("Chennai",13.0827,80.2707),
("Hyderabad",17.3850,78.4867),
("Ahmedabad",23.0225,72.5714),
("Jaipur",26.9124,75.7873),
("Lucknow",26.8467,80.9462),
("Nagpur",21.1458,79.0882),
("Indore",22.7196,75.8577),
("Bhopal",23.2599,77.4126),
("Surat",21.1702,72.8311),
("Patna",25.5941,85.1376),
("Kochi",9.9312,76.2673),
("Panaji",15.4909,73.8278),
("Shimla",31.1048,77.1734),
("Srinagar",34.0837,74.7973),
("Guwahati",26.1445,91.7362),
("Bhubaneswar",20.2961,85.8245)
]

RUNS=50

conn=mysql.connector.connect(
host="localhost",
user="root",
password="password",
database="weatherdb"
)

cursor=conn.cursor()

print("=== Weather ETL Started ===")

total=0

for run in range(RUNS):
    print(f"Run {run+1}/{RUNS}")
    for city,lat,lon in cities:
        url=f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&current=temperature_2m,relative_humidity_2m,wind_speed_10m"
        r=requests.get(url)
        if r.status_code!=200:
            print(f"API Failed: {city}")
            continue
        data=r.json()["current"]
        cursor.execute(
            "INSERT INTO weather(city,temperature,humidity,wind_speed) VALUES(%s,%s,%s,%s)",
            (city,data["temperature_2m"],data["relative_humidity_2m"],data["wind_speed_10m"])
        )
        conn.commit()
        total+=1
        print(f"Inserted {city}")

cursor.close()
conn.close()

print(f"Total Records Inserted: {total}")
print("Connection Closed")
print("Pipeline Completed Successfully")
```

## Execute

``` bash
python3 weather_etl.py
```

Expected Output

-   Connected to MySQL
-   Inserted `<City Name>`{=html}
-   Total Records Inserted: 1000
-   Connection Closed
-   Pipeline Completed Successfully


# Section 6: Generating Dataset (20 Cities × 50 Runs)

## Objective

Generate a realistic weather dataset before importing it into Hadoop.

### Dataset Configuration

  Parameter           Value
  ----------------- -------
  Cities                 20
  Runs                   50
  Records per Run        20
  Total Records        1000

The Python ETL script loops through 20 predefined Indian cities and
repeats the process 50 times.

``` text
Run 1
 ├── Mumbai
 ├── Delhi
 ├── Pune
 └── ...20 cities

Run 2
 ├── Mumbai
 └── ...20 cities

...
Run 50
```

Execute:

``` bash
python3 weather_etl.py
```

Expected console output:

``` text
=== Weather ETL Started ===
Run 1/50
Inserted Mumbai
Inserted Delhi
...
Run 50/50
Total Records Inserted : 1000
Connection Closed
Pipeline Completed Successfully
```

Verify in MySQL:

``` sql
USE weatherdb;
SELECT COUNT(*) FROM weather;
SELECT * FROM weather LIMIT 10;
```

Expected:

``` text
1000
```

------------------------------------------------------------------------

# Section 7: Sqoop Import

## Objective

Transfer weather data from MySQL into Hadoop HDFS.

### Step 1: Verify Hadoop

``` bash
jps
```

Expected services:

-   NameNode
-   DataNode
-   ResourceManager
-   NodeManager

### Step 2: Verify Sqoop

``` bash
sqoop version
```

### Step 3: Import Table

``` bash
sqoop import \
--connect jdbc:mysql://localhost/weatherdb \
--username root \
--password password \
--table weather \
--target-dir /weatherdata \
-m 2
```

### Explanation of Parameters

  Parameter      Description
  -------------- --------------------------
  --connect      MySQL JDBC URL
  --username     Database username
  --password     Database password
  --table        Table to import
  --target-dir   HDFS destination
  -m 2           Use two parallel mappers

Expected output:

``` text
Connecting to MySQL...
Compiling Sqoop Job...
Launching MapReduce Job...
Completed Successfully.
```

------------------------------------------------------------------------

# Section 8: HDFS Verification

## List Imported Files

``` bash
hadoop fs -ls /weatherdata
```

Expected:

``` text
part-m-00000
part-m-00001
_SUCCESS
```

## Display Data

``` bash
hadoop fs -cat /weatherdata/part-m-00000
```

## Verify Record Count

``` bash
hdfs dfs -cat /weatherdata/part-* | wc -l
```

Expected:

``` text
1000
```

Compare with MySQL:

``` sql
SELECT COUNT(*) FROM weather;
```

Both counts should match.

------------------------------------------------------------------------

# Section 9: Hive Import & Analytics

## Import into Hive

``` bash
sqoop import \
--connect jdbc:mysql://localhost/weatherdb \
--username root \
--password password \
--table weather \
--hive-import \
--create-hive-table \
--hive-table weather.weather
```

Open Hive:

``` bash
hive
```

Verify:

``` sql
USE weather;

SELECT COUNT(*) FROM weather;
```

### Sample Analytics

Average temperature by city

``` sql
SELECT city,AVG(temperature)
FROM weather
GROUP BY city;
```

Highest recorded temperature

``` sql
SELECT city,MAX(temperature)
FROM weather
GROUP BY city;
```

Average humidity

``` sql
SELECT AVG(humidity)
FROM weather;
```

Maximum wind speed

``` sql
SELECT MAX(wind_speed)
FROM weather;
```

------------------------------------------------------------------------

# Section 10: Viva, Assignments & Troubleshooting

## Viva Questions

1.  What is Apache Sqoop?
2.  Why is MySQL used before Sqoop?
3.  Why can't Sqoop directly read REST APIs?
4.  What is JDBC?
5.  Explain ETL.
6.  Difference between Sqoop Import and Export.
7.  Why are multiple part files created in HDFS?
8.  What is the purpose of `-m`?
9.  Why is Hive used after HDFS?
10. What would happen if `conn.commit()` is omitted in Python?

## Assignments

1.  Import only selected columns using `--columns`.
2.  Import records using a WHERE clause.
3.  Compare execution time using `-m 1`, `-m 2`, and `-m 4`.
4.  Extend the ETL script to collect data for another 10 cities.
5.  Modify the ETL script to collect weather every hour using a
    scheduler.
6.  Import data into Hive and identify the hottest city.
7.  Perform an incremental Sqoop import after inserting additional
    records.

## Troubleshooting

  -----------------------------------------------------------------------
  Problem                           Solution
  --------------------------------- -------------------------------------
  mysql: command not found          Install MySQL and restart terminal

  Connection refused                Start MySQL service

  Sqoop cannot connect              Verify JDBC driver is present in
                                    `$SQOOP_HOME/lib`

  Hadoop services not running       Execute `start-dfs.sh` and
                                    `start-yarn.sh`

  HDFS directory exists             Remove using
                                    `hadoop fs -rm -r /weatherdata`
                                    before re-import

  Hive table already exists         Drop table or use a different Hive
                                    table name

  API request failed                Check internet connectivity and retry
  -----------------------------------------------------------------------

## Expected Final Pipeline

``` text
Open-Meteo API
      │
Python ETL
      │
MySQL
      │
Sqoop
      │
HDFS
      │
Hive
      │
Analytics
```

## Conclusion

Successfully generated a weather dataset, transferred it from MySQL to
Hadoop using Sqoop, verified the imported data in HDFS, created a Hive
table, and performed analytical SQL queries.
