Part 2 Complete Laboratory Manual

## Industry-Grade MongoDB database storage through ETL Pipeline using REST API, Python.

**Subject:** Big Data Analytics LAB
# Objectives

After completing this experiment, students will be able to:

1.  Deploy the ETL Pipeline to store data in MongoDB
2.  Retrieve JSON data from a REST API.
3.  Validate incoming data.
4.  Transform JSON documents.
5.  Store documents in MongoDB.
6.  Perform CRUD operations.
7.  Execute aggregation pipelines.
8.  Export data to JSON and CSV.
9.  Build a modular ETL application.

------------------------------------------------------------------------

# Learning Outcomes

Students will be able to:

-   Design an MongoDB database workflow.
-   Consume REST APIs.
-   Process semi-structured JSON data.
-   Validate and transform data.
-   Perform incremental loading using Upsert.
-   Query MongoDB using CRUD and Aggregation.
-   Export processed datasets.
-   Develop modular Python applications.

  # Architecture

``` text
REST API
   │
   ▼
Extract
   │
   ▼
Validation
   │
   ▼
Transformation
   │
   ▼
MongoDB (Upsert)
   │
   ├── CRUD
   ├── Aggregation
   └── Export JSON / CSV
```

------------------------------------------------------------------------

# REST API

A REST API allows applications to communicate over HTTP.

HTTP methods:

  Method   Purpose
  -------- ---------------
  GET      Retrieve data
  POST     Create data
  PUT      Replace data
  PATCH    Update data
  DELETE   Delete data

This experiment uses only the **GET** method.

API Endpoint:

``` text
https://dummyjson.com/products
```

------------------------------------------------------------------------

# Sample JSON

``` json
{
  "id":1,
  "title":"Essence Mascara Lash Princess",
  "price":9.99,
  "category":"beauty",
  "brand":"Essence",
  "rating":2.56,
  "stock":99
}
```

------------------------------------------------------------------------

# MongoDB Overview

MongoDB is a NoSQL document-oriented database that stores information as
BSON documents.

  Relational Database   MongoDB
  --------------------- ------------
  Database              Database
  Table                 Collection
  Row                   Document
  Column                Field
  Primary Key           ObjectId

Advantages:

-   Flexible schema
-   Native JSON-like documents
-   High scalability
-   Excellent Python integration

------------------------------------------------------------------------

# Project Modules

  File              Responsibility
  ----------------- ----------------------
  config.py         Configuration
  extractor.py      Download data
  validator.py      Validate data
  transformer.py    Transform data
  loader.py         Load into MongoDB
  exporter.py       Export JSON/CSV
  products_etl.py   Execute ETL workflow

------------------------------------------------------------------------

# Software Requirements

-   Ubuntu 24.04 LTS
-   Python 3.11+
-   MongoDB 8.x
-   MongoDB Compass
-   Internet connection

------------------------------------------------------------------------

# Prerequisites

Students should have completed:

-   Experiment 04 -- Part 1 (MongoDB Installation)
-   Basic Linux Commands
-   Python Fundamentals
-   JSON Basics
-   MongoDB CRUD Operations

------------------------------------------------------------------------

# Project Structure (Preview)

``` text
Exp04_Part2/
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── exports/
├── logs/
├── output/
├── config.py
├── extractor.py
├── validator.py
├── transformer.py
├── loader.py
├── exporter.py
├── products_etl.py
├── requirements.txt
└── README.md
```

------------------------------------------------------------------------

# Experiment Workflow

``` text
Create Workspace
      │
      ▼
Configure Python
      │
      ▼
Test REST API
      │
      ▼
Develop ETL Modules
      │
      ▼
Execute ETL
      │
      ▼
Verify MongoDB
      │
      ▼
CRUD Operations
      │
      ▼
Aggregation
      │
      ▼
Export JSON / CSV
```

------------------------------------------------------------------------

# Checkpoint

Before proceeding to **Part A.2**, you should understand:

-   ETL workflow
-   REST API basics
-   JSON structure
-   MongoDB document model
-   Purpose of each ETL module

------------------------------------------------------------------------

# PART A.2 -- Environment Setup

This section performs the initial environment setup required before
building the ETL pipeline.

------------------------------------------------------------------------

# Step 1 -- Create the Project Workspace

## Aim

Create a dedicated project directory for the ETL experiment.

## Command

``` bash
mkdir -p ~/Exp04_Part2
cd ~/Exp04_Part2
pwd
```

## Command Explanation

  Command    Purpose
  ---------- ----------------------------------------------------
  mkdir -p   Creates the directory if it does not already exist
  cd         Changes to the project directory
  pwd        Displays the current working directory

## Expected Output

``` text
/home/<username>/Exp04_Part2
```

## Verification

``` bash
ls
```

The directory should be empty.

## Common Errors

**Permission denied**

Solution: Create the folder inside your home directory (`~`).

------------------------------------------------------------------------

# Step 2 -- Create the Project Directory Structure

## Aim

Organize the project using an industry-standard folder layout.

## Commands

``` bash
mkdir -p data/raw
mkdir -p data/processed
mkdir -p data/exports
mkdir logs
mkdir output
```

Verify:

``` bash
tree .
```

If `tree` is not installed:

``` bash
sudo apt install tree -y
tree .
```

## Expected Structure

``` text
Exp04_Part2/
├── data/
│   ├── raw/
│   ├── processed/
│   └── exports/
├── logs/
└── output/
```

------------------------------------------------------------------------

# Step 3 -- Create a Python Virtual Environment

## Why?

A virtual environment isolates project dependencies from the system
Python installation.

## Commands

``` bash
python3 -m venv venv
```

Activate:

``` bash
source venv/bin/activate
```

Verify:

``` bash
python --version
which python
```

## Expected Output

The prompt changes to:

``` text
(venv)
```

------------------------------------------------------------------------

# Step 4 -- Install Required Packages

## Aim

Install all Python libraries required for the ETL pipeline.

## Command

``` bash
pip install requests pymongo pandas
```

Save dependency list:

``` bash
pip freeze > requirements.txt
```

Verify:

``` bash
pip list
```

Packages should include:

-   requests
-   pymongo
-   pandas

------------------------------------------------------------------------

# Step 5 -- Verify MongoDB

Ensure the MongoDB service is running.

``` bash
sudo systemctl status mongod
```

Expected:

``` text
Active: active (running)
```

Connect:

``` bash
mongosh
```

Inside MongoDB:

``` javascript
show dbs
exit
```

------------------------------------------------------------------------

# Step 6 -- Test the REST API

## Aim

Verify that the API is reachable before writing any Python code.

Command:

``` bash
curl https://dummyjson.com/products | head
```

## Explanation

  Part      Meaning
  --------- -----------------------------------
  curl      Sends an HTTP GET request
  URL       REST API endpoint
  \| head   Displays only the first few lines

Expected:

``` json
{
  "products":[
```

------------------------------------------------------------------------

# Step 7 -- Create Initial Project Files

Create all source files now.

``` bash
touch config.py
touch extractor.py
touch validator.py
touch transformer.py
touch loader.py
touch exporter.py
touch products_etl.py
```

Verify:

``` bash
ls
```

Expected:

``` text
config.py
extractor.py
validator.py
transformer.py
loader.py
exporter.py
products_etl.py
requirements.txt
```

------------------------------------------------------------------------

# Checkpoint

At this stage you should have:

-   Project workspace created
-   Folder structure created
-   Python virtual environment activated
-   Dependencies installed
-   MongoDB verified
-   REST API tested
-   Empty Python source files created

------------------------------------------------------------------------

# Troubleshooting

## ModuleNotFoundError

Activate the virtual environment again:

``` bash
source venv/bin/activate
```

## mongosh: command not found

Complete Experiment 04 Part 1 and verify MongoDB installation.

## curl: command not found

``` bash
sudo apt install curl -y
```

------------------------------------------------------------------------

# PART B.1 -- Creating `config.py` and `extractor.py`

## Objective

In this part, students will create the first two modules of the ETL
project:

-   `config.py` -- stores configuration values.
-   `extractor.py` -- retrieves product data from the REST API.

------------------------------------------------------------------------

# Module 1 -- config.py

## Aim

Create a central configuration file so application settings are
maintained in one place.

## Step 1: Create the file

``` bash
nano config.py
```

## Step 2: Enter the following code

``` python
API_URL = "https://dummyjson.com/products"
MONGO_URI = "mongodb://localhost:27017/"
DATABASE = "ProductDB"
COLLECTION = "products"
REQUEST_TIMEOUT = 10
```

## Explanation

  Variable          Purpose
  ----------------- ---------------------------
  API_URL           REST API endpoint
  MONGO_URI         MongoDB connection string
  DATABASE          Database name
  COLLECTION        Collection name
  REQUEST_TIMEOUT   HTTP timeout (seconds)

## Save

Press:

``` text
Ctrl + O
Enter
Ctrl + X
```

## Verify

``` bash
cat config.py
```

------------------------------------------------------------------------

# Module 2 -- extractor.py

## Aim

Download JSON data from the REST API.

## Step 1: Create the file

``` bash
nano extractor.py
```

## Step 2: Enter the following code

``` python
import requests
from config import API_URL, REQUEST_TIMEOUT

def extract_data():
    response = requests.get(API_URL, timeout=REQUEST_TIMEOUT)
    response.raise_for_status()

    payload = response.json()
    return payload["products"]


if __name__ == "__main__":
    products = extract_data()
    print(f"Downloaded {len(products)} products.")
    print(products[0])
```

## Code Explanation

-   `requests.get()` sends an HTTP GET request.
-   `timeout` prevents the request from waiting indefinitely.
-   `raise_for_status()` raises an exception if the server returns an
    error.
-   `response.json()` converts JSON into Python objects.
-   The API response contains a key named `products`; the function
    returns only that list.

------------------------------------------------------------------------

# Run the Program

``` bash
python extractor.py
```

## Expected Output

``` text
Downloaded 194 products.
{'id': 1, 'title': 'Essence Mascara Lash Princess', ...}
```

(The exact number of products may change if the API is updated.)

------------------------------------------------------------------------

# Verification

Confirm that:

-   The program runs without errors.
-   The number of downloaded products is displayed.
-   The first product is printed as a Python dictionary.

------------------------------------------------------------------------

# Common Errors

## ModuleNotFoundError: requests

Install the package:

``` bash
pip install requests
```

## ConnectionError

Check your internet connection and verify that the API endpoint is
reachable:

``` bash
curl https://dummyjson.com/products
```

## Timeout

Increase `REQUEST_TIMEOUT` in `config.py` if your network is slow.

------------------------------------------------------------------------

# Checkpoint

At the end of this section, you should have:

-   A reusable configuration module.
-   A working extractor module.
-   Successful retrieval of product data from the REST API.

------------------------------------------------------------------------

# PART B.2 -- Creating `validator.py` and `transformer.py`

## Objective

In this part you will:

-   Validate records received from the REST API.
-   Reject incomplete or invalid records.
-   Transform the data into a MongoDB-friendly format.

------------------------------------------------------------------------

# Module 3 -- validator.py

## Aim

Validate every product before it is loaded into MongoDB.

## Why Validation?

Real-world data can contain:

-   Missing values
-   Invalid data types
-   Negative prices
-   Empty fields

Validation improves data quality before loading.

------------------------------------------------------------------------

## Step 1 -- Create the file

``` bash
nano validator.py
```

------------------------------------------------------------------------

## Step 2 -- Enter the following code

``` python
def validate_product(product):
    required_fields = ["id", "title", "price", "category"]

    for field in required_fields:
        if field not in product:
            return False

    if not isinstance(product["price"], (int, float)):
        return False

    if product["price"] < 0:
        return False

    if str(product["title"]).strip() == "":
        return False

    return True
```

------------------------------------------------------------------------

## Code Explanation

  Code              Purpose
  ----------------- ----------------------------
  required_fields   Fields that must exist
  for loop          Checks each required field
  isinstance()      Confirms numeric price
  price \< 0        Rejects invalid prices
  strip()           Rejects empty titles
  return True       Record passed validation

------------------------------------------------------------------------

## Quick Test

Create a temporary test file.

``` bash
nano test_validator.py
```

``` python
from validator import validate_product

sample = {
    "id":1,
    "title":"Laptop",
    "price":65000,
    "category":"electronics"
}

print(validate_product(sample))
```

Run:

``` bash
python test_validator.py
```

Expected:

``` text
True
```

------------------------------------------------------------------------

# Module 4 -- transformer.py

## Aim

Transform validated records into the desired schema.

------------------------------------------------------------------------

## Why Transformation?

Transformation helps to:

-   Standardize field names
-   Add metadata
-   Flatten nested objects
-   Convert data types
-   Prepare documents for analytics

------------------------------------------------------------------------

## Step 1 -- Create the file

``` bash
nano transformer.py
```

------------------------------------------------------------------------

## Step 2 -- Enter the following code

``` python
from datetime import datetime

def transform_product(product):
    transformed = {
        "_id": product["id"],
        "product_name": product["title"],
        "product_price": float(product["price"]),
        "product_category": product["category"],
        "manufacturer": product.get("brand", "Unknown"),
        "rating": product.get("rating", 0),
        "stock": product.get("stock", 0),
        "source": "DummyJSON API",
        "ingestion_date": datetime.utcnow().isoformat()
    }

    if "dimensions" in product:
        dims = product["dimensions"]
        transformed["width"] = dims.get("width")
        transformed["height"] = dims.get("height")
        transformed["depth"] = dims.get("depth")

    return transformed
```

------------------------------------------------------------------------

## Field Mapping

  API Field   MongoDB Field
  ----------- ------------------
  id          \_id
  title       product_name
  price       product_price
  category    product_category
  brand       manufacturer

------------------------------------------------------------------------

## Code Explanation

-   `_id` is mapped from the API `id` to avoid duplicate documents.
-   `get()` safely retrieves optional fields.
-   `float()` ensures a consistent numeric type.
-   `ingestion_date` stores when the record entered the system.
-   Nested `dimensions` are flattened into separate fields.

------------------------------------------------------------------------

## Test the Transformer

Create:

``` bash
nano test_transformer.py
```

``` python
from transformer import transform_product

sample = {
    "id":1,
    "title":"Laptop",
    "price":65000,
    "category":"electronics",
    "brand":"ABC",
    "dimensions":{
        "width":25,
        "height":2,
        "depth":18
    }
}

print(transform_product(sample))
```

Run:

``` bash
python test_transformer.py
```

Expected output includes:

``` text
{
 '_id': 1,
 'product_name': 'Laptop',
 'product_price': 65000.0,
 'manufacturer': 'ABC',
 'width': 25,
 'height': 2,
 'depth': 18,
 ...
}
```

------------------------------------------------------------------------

# Checkpoint

You should now have:

-   `validator.py`
-   `transformer.py`
-   Successful validation tests
-   Successful transformation tests

------------------------------------------------------------------------

# Common Errors

## KeyError

Ensure required fields exist before transformation.

## IndentationError

Use consistent indentation (4 spaces).

## SyntaxError

Check missing commas, quotes, or brackets.

------------------------------------------------------------------------

# Summary

In this section you learned how to:

-   Validate incoming JSON records.
-   Reject invalid data.
-   Rename fields.
-   Flatten nested objects.
-   Add metadata.
-   Prepare clean MongoDB documents.

------------------------------------------------------------------------

**PART B.3 -- Creating `loader.py` and `exporter.py`**
# Module 1 -- `loader.py`

## Step 1 -- Create the file

``` bash
nano loader.py
```

## Step 2 -- Code

``` python
from pymongo import MongoClient
from config import MONGO_URI, DATABASE, COLLECTION

def load_products(products):
    client = MongoClient(MONGO_URI)
    db = client[DATABASE]
    collection = db[COLLECTION]

    for product in products:
        collection.replace_one(
            {"_id": product["_id"]},
            product,
            upsert=True
        )

    print(f"Loaded {len(products)} products into MongoDB.")
    client.close()

if __name__ == "__main__":
    print("Run products_etl.py to load products.")
```

### Explanation

-   `MongoClient()` connects to MongoDB.
-   `db[COLLECTION]` selects the collection.
-   `replace_one(..., upsert=True)` updates existing documents or
    inserts new ones.
-   `client.close()` closes the database connection.

``` text
Exp04_Part2/
├── data/
│   ├── raw/
│   ├── processed/
│   └── exports/
├── logs/
├── output/
├── config.py
├── extractor.py
├── validator.py
├── transformer.py
├── loader.py
├── exporter.py
├── products_etl.py
├── requirements.txt
└── README.md
```

------------------------------------------------------------------------

# Appendix C -- Student Submission Checklist

## Source Code

-   [ ] config.py
-   [ ] extractor.py
-   [ ] validator.py
-   [ ] transformer.py
-   [ ] loader.py
-   [ ] exporter.py
-   [ ] products_etl.py

## Output Files

-   [ ] products.json
-   [ ] products.csv
-   [ ] MongoDB database populated

## Evidence

-   [ ] Terminal screenshots
-   [ ] MongoDB Compass screenshots
-   [ ] CRUD query screenshots
-   [ ] Aggregation screenshots

------------------------------------------------------------------------

# References

1.  MongoDB Documentation -- https://www.mongodb.com/docs/
2.  PyMongo Documentation -- https://pymongo.readthedocs.io/
3.  Python Documentation -- https://docs.python.org/3/
4.  DummyJSON API -- https://dummyjson.com/

------------------------------------------------------------------------

# End of Manual

This manual is intended for classroom instruction, guided laboratory
sessions, self-learning, and assessment preparation.
