# Experiment 04 -- Part 1

# Step 11 -- Start MongoDB

If your WSL supports **systemd** (recommended):

``` bash
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod
```

Status should show:

``` text
Active: active (running)
```

If `systemctl` is unavailable, use:

``` bash
mongod --dbpath /data/db
```

------------------------------------------------------------------------

# Step 12 -- Connect to MongoDB

Open a new Ubuntu terminal.

``` bash
mongosh
```

Expected prompt:

``` text
test>
```

------------------------------------------------------------------------

# MongoDB CRUD Practice

## Show Databases

``` javascript
show dbs
```

## Create / Switch Database

``` javascript
use CollegeDB
```

## Create Collection

``` javascript
db.createCollection("students")
```

## Show Collections

``` javascript
show collections
```

## Insert One Document

``` javascript
db.students.insertOne({
    roll:1,
    name:"Akshay",
    department:"AIDS",
    semester:7,
