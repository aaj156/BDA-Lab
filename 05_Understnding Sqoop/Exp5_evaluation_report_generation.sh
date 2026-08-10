#!/bin/bash

###############################################################################
# Experiment 05 Evaluation System
# Subject      : Big Data Analytics Laboratory
# Experiment   : Weather Data Ingestion Pipeline using
#                Open API, Python ETL, MySQL, Sqoop, HDFS & Hive
#
# Department   : Artificial Intelligence & Data Science
# College      : SIES Graduate School of Technology
#
# Author       : Prof. Akshay A. Jadhav
###############################################################################

clear

##############################################
# Configuration
##############################################

COLLEGE="SIES Graduate School of Technology"
DEPARTMENT="Department of Artificial Intelligence & Data Science"
SUBJECT="Big Data Analytics Laboratory"

EXPERIMENT_NO="05"

EXPERIMENT_TITLE="Weather Data Ingestion Pipeline using Open API, Python ETL, MySQL, Sqoop, HDFS and Hive"

FACULTY="Prof. Akshay A. Jadhav"

TOTAL_MARKS=100

##############################################
# Colours
##############################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

##############################################
# Banner
##############################################

echo -e "${CYAN}"
echo "=============================================================="
echo "        SIES Graduate School of Technology"
echo "     Big Data Analytics Laboratory Evaluation System"
echo "=============================================================="
echo -e "${NC}"

##############################################
# Student Information
##############################################

read -p "Enter Roll Number : " ROLLNO

read -p "Enter Student Name : " STUDENT_NAME

read -p "Enter Division : " DIVISION

read -p "Enter Batch : " BATCH

DATE=$(date +"%d-%m-%Y")

REPORT_FILE="${ROLLNO}_Exp05_Sqoop.txt"

CSV_FILE="marks.csv"

LOG_FILE="evaluation.log"

##############################################
# Marks Initialization
##############################################

TOTAL=0

JAVA=0
PYTHON=0
HADOOP=0
HADOOP_RUN=0
MYSQL=0
SQOOP=0
HIVE=0
DATABASE=0
TABLE=0
PYTHON_SCRIPT=0
RECORDS=0
DATASET=0
HDFS_IMPORT=0
HDFS_COUNT=0
HIVE_IMPORT=0
HIVE_COUNT=0

##############################################
# Marks Allocation
##############################################

JAVA_MARK=2
PYTHON_MARK=2
HADOOP_MARK=5
HADOOP_RUN_MARK=8
MYSQL_MARK=3
SQOOP_MARK=5
HIVE_MARK=5
DATABASE_MARK=5
TABLE_MARK=5
PYTHON_SCRIPT_MARK=5
RECORDS_MARK=10
DATASET_MARK=10
HDFS_IMPORT_MARK=8
HDFS_COUNT_MARK=10
HIVE_IMPORT_MARK=7
HIVE_COUNT_MARK=10

##############################################
# Progress Variables
##############################################

TOTAL_STEPS=16
CURRENT_STEP=0

##############################################
# Utility Functions
##############################################

next_step(){

CURRENT_STEP=$((CURRENT_STEP+1))

echo
echo "-----------------------------------------------------"
echo "[${CURRENT_STEP}/${TOTAL_STEPS}] $1"
echo "-----------------------------------------------------"

}

##############################################

pass(){

echo -e "${GREEN}✔ PASS${NC}"

}

##############################################

fail(){

echo -e "${RED}✘ FAIL${NC}"

}

##############################################

warning(){

echo -e "${YELLOW}$1${NC}"

}

##############################################

info(){

echo -e "${BLUE}$1${NC}"

}

##############################################

add_marks(){

TOTAL=$((TOTAL+$1))

}

##############################################

write_report(){

echo "$1" >> "$REPORT_FILE"

}

##############################################

log(){

echo "$(date) : $1" >> "$LOG_FILE"

}

##############################################
# Initialize Report
##############################################

rm -f "$REPORT_FILE"

touch "$REPORT_FILE"

echo "==============================================================" >> "$REPORT_FILE"
echo "        SIES Graduate School of Technology" >> "$REPORT_FILE"
echo "Department : Artificial Intelligence & Data Science" >> "$REPORT_FILE"
echo "Subject    : Big Data Analytics Laboratory" >> "$REPORT_FILE"
echo "==============================================================" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"

echo "Experiment No    : $EXPERIMENT_NO" >> "$REPORT_FILE"

echo "Experiment Title : $EXPERIMENT_TITLE" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "Student Name     : $STUDENT_NAME" >> "$REPORT_FILE"

echo "Roll Number      : $ROLLNO" >> "$REPORT_FILE"

echo "Division         : $DIVISION" >> "$REPORT_FILE"

echo "Batch            : $BATCH" >> "$REPORT_FILE"

echo "Faculty          : $FACULTY" >> "$REPORT_FILE"

echo "Date             : $DATE" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "==============================================================" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

##############################################
# Initialize CSV
##############################################

if [ ! -f "$CSV_FILE" ]; then

echo "Roll No,Student Name,Division,Batch,Experiment No,Marks,Grade,Date" > "$CSV_FILE"

fi

##############################################
# Start Evaluation
##############################################

echo

echo -e "${GREEN}Report File : ${REPORT_FILE}${NC}"

echo

echo -e "${GREEN}Evaluation Started...${NC}"

log "Evaluation Started"

sleep 1

###############################################################################
# END OF PART 1
###############################################################################

echo
echo "-----------------------------------------------------------"
echo " Part 1 Loaded Successfully"
echo " Continue with Part 2"
echo "-----------------------------------------------------------"

###############################################################################
# PART 2 : Evaluation Engine
###############################################################################

###############################
# Java Verification
###############################

next_step "Checking Java Installation"

if command -v java >/dev/null 2>&1; then
    pass
    JAVA=$JAVA_MARK
    add_marks $JAVA_MARK
    write_report "Java Installation           : PASS ($JAVA_MARK/$JAVA_MARK)"
else
    fail
    write_report "Java Installation           : FAIL (0/$JAVA_MARK)"
fi

###############################
# Python Verification
###############################

next_step "Checking Python Installation"

if command -v python3 >/dev/null 2>&1; then
    pass
    PYTHON=$PYTHON_MARK
    add_marks $PYTHON_MARK
    write_report "Python Installation         : PASS ($PYTHON_MARK/$PYTHON_MARK)"
else
    fail
    write_report "Python Installation         : FAIL (0/$PYTHON_MARK)"
fi

###############################
# Hadoop Verification
###############################

next_step "Checking Hadoop Installation"

if command -v hadoop >/dev/null 2>&1; then
    pass
    HADOOP=$HADOOP_MARK
    add_marks $HADOOP_MARK
    write_report "Hadoop Installation         : PASS ($HADOOP_MARK/$HADOOP_MARK)"
else
    fail
    write_report "Hadoop Installation         : FAIL (0/$HADOOP_MARK)"
fi

###############################
# Hadoop Services
###############################

next_step "Checking Hadoop Services"

if jps | grep -q "NameNode"; then
    pass
    HADOOP_RUN=$HADOOP_RUN_MARK
    add_marks $HADOOP_RUN_MARK
    write_report "Hadoop Services            : PASS ($HADOOP_RUN_MARK/$HADOOP_RUN_MARK)"
else
    fail
    write_report "Hadoop Services            : FAIL (0/$HADOOP_RUN_MARK)"
fi

###############################
# MySQL
###############################

next_step "Checking MySQL"

if command -v mysql >/dev/null 2>&1; then
    pass
    MYSQL=$MYSQL_MARK
    add_marks $MYSQL_MARK
    write_report "MySQL                      : PASS ($MYSQL_MARK/$MYSQL_MARK)"
else
    fail
    write_report "MySQL                      : FAIL (0/$MYSQL_MARK)"
fi

###############################
# Sqoop
###############################

next_step "Checking Sqoop"

if command -v sqoop >/dev/null 2>&1; then
    pass
    SQOOP=$SQOOP_MARK
    add_marks $SQOOP_MARK
    write_report "Sqoop                      : PASS ($SQOOP_MARK/$SQOOP_MARK)"
else
    fail
    write_report "Sqoop                      : FAIL (0/$SQOOP_MARK)"
fi

###############################
# Hive
###############################

next_step "Checking Hive"

if command -v hive >/dev/null 2>&1; then
    pass
    HIVE=$HIVE_MARK
    add_marks $HIVE_MARK
    write_report "Hive                       : PASS ($HIVE_MARK/$HIVE_MARK)"
else
    fail
    write_report "Hive                       : FAIL (0/$HIVE_MARK)"
fi

###############################
# Database
###############################

next_step "Checking weatherdb"

DB_EXISTS=$(mysql -N -B -u root -ppassword -e "SHOW DATABASES LIKE 'weatherdb';" 2>/dev/null)

if [ "$DB_EXISTS" = "weatherdb" ]; then
    pass
    DATABASE=$DATABASE_MARK
    add_marks $DATABASE_MARK
    write_report "Database weatherdb         : PASS ($DATABASE_MARK/$DATABASE_MARK)"
else
    fail
    write_report "Database weatherdb         : FAIL (0/$DATABASE_MARK)"
fi

###############################
# Weather Table
###############################

next_step "Checking weather Table"

TABLE_EXISTS=$(mysql -N -B -u root -ppassword weatherdb -e "SHOW TABLES LIKE 'weather';" 2>/dev/null)

if [ "$TABLE_EXISTS" = "weather" ]; then
    pass
    TABLE=$TABLE_MARK
    add_marks $TABLE_MARK
    write_report "Table weather             : PASS ($TABLE_MARK/$TABLE_MARK)"
else
    fail
    write_report "Table weather             : FAIL (0/$TABLE_MARK)"
fi

###############################
# Python ETL Script
###############################

next_step "Checking weather_etl.py"

if [ -f "weather_etl.py" ]; then

    SCORE=0

    grep -q "requests" weather_etl.py && SCORE=$((SCORE+1))
    grep -q "mysql.connector" weather_etl.py && SCORE=$((SCORE+1))
    grep -q "open-meteo" weather_etl.py && SCORE=$((SCORE+1))
    grep -q "RUNS *= *50" weather_etl.py && SCORE=$((SCORE+1))
    grep -q "INSERT INTO weather" weather_etl.py && SCORE=$((SCORE+1))

    PYTHON_SCRIPT=$SCORE
    add_marks $SCORE

    pass

    write_report "Python ETL Script         : PASS ($SCORE/$PYTHON_SCRIPT_MARK)"

else

    fail

    write_report "Python ETL Script         : FAIL (0/$PYTHON_SCRIPT_MARK)"

fi

###############################
# Record Count
###############################

next_step "Checking Weather Records"

COUNT=$(mysql -N -B -u root -ppassword weatherdb -e "SELECT COUNT(*) FROM weather;" 2>/dev/null)

if [ -z "$COUNT" ]; then
    COUNT=0
fi

if [ "$COUNT" -ge 1000 ]; then

    RECORDS=$RECORDS_MARK
    DATASET=$DATASET_MARK

    add_marks $RECORDS_MARK
    add_marks $DATASET_MARK

    pass

    write_report "Weather Records           : $COUNT"
    write_report "Dataset Generation        : PASS (20 Cities × 50 Runs)"

elif [ "$COUNT" -gt 0 ]; then

    RECORDS=5

    add_marks 5

    warning "Only $COUNT records found"

    write_report "Weather Records           : $COUNT (Partial Marks)"

else

    fail

    write_report "Weather Records           : No Records Found"

fi

echo
echo "---------------------------------------------"
echo "Part 2 Evaluation Completed"
echo "Current Marks : $TOTAL / 100"
echo "---------------------------------------------"

###############################################################################
# PART 3 : HDFS, Hive, Report Generation & Final Evaluation
###############################################################################

###############################
# HDFS Directory Verification
###############################

next_step "Checking HDFS Import"

if hdfs dfs -test -d /weatherdata 2>/dev/null
then
    pass
    HDFS_IMPORT=$HDFS_IMPORT_MARK
    add_marks $HDFS_IMPORT_MARK
    write_report "HDFS Directory            : PASS ($HDFS_IMPORT_MARK/$HDFS_IMPORT_MARK)"
else
    fail
    write_report "HDFS Directory            : FAIL (0/$HDFS_IMPORT_MARK)"
fi

###############################
# HDFS Record Count
###############################

next_step "Checking HDFS Record Count"

HDFS_COUNT_VALUE=$(hdfs dfs -cat /weatherdata/part-* 2>/dev/null | wc -l)

if [ -z "$HDFS_COUNT_VALUE" ]; then
    HDFS_COUNT_VALUE=0
fi

MYSQL_COUNT=$(mysql -N -B -u root -ppassword weatherdb \
-e "SELECT COUNT(*) FROM weather;" 2>/dev/null)

if [ -z "$MYSQL_COUNT" ]; then
    MYSQL_COUNT=0
fi

if [ "$HDFS_COUNT_VALUE" -eq "$MYSQL_COUNT" ] && [ "$MYSQL_COUNT" -gt 0 ]
then
    pass
    HDFS_COUNT=$HDFS_COUNT_MARK
    add_marks $HDFS_COUNT_MARK
    write_report "HDFS Record Count         : PASS ($HDFS_COUNT_MARK/$HDFS_COUNT_MARK)"
else
    fail
    write_report "HDFS Record Count         : FAIL (0/$HDFS_COUNT_MARK)"
fi

###############################
# Hive Table Verification
###############################

next_step "Checking Hive Import"

HIVE_TABLE=$(hive -S -e "SHOW TABLES IN weather;" 2>/dev/null | grep "^weather$")

if [ "$HIVE_TABLE" = "weather" ]
then
    pass
    HIVE_IMPORT=$HIVE_IMPORT_MARK
    add_marks $HIVE_IMPORT_MARK
    write_report "Hive Table               : PASS ($HIVE_IMPORT_MARK/$HIVE_IMPORT_MARK)"
else
    fail
    write_report "Hive Table               : FAIL (0/$HIVE_IMPORT_MARK)"
fi

###############################
# Hive Record Count
###############################

next_step "Checking Hive Record Count"

HIVE_COUNT_VALUE=$(hive -S -e "SELECT COUNT(*) FROM weather.weather;" 2>/dev/null)

if [ -z "$HIVE_COUNT_VALUE" ]; then
    HIVE_COUNT_VALUE=0
fi

if [ "$HIVE_COUNT_VALUE" -eq "$MYSQL_COUNT" ] && [ "$MYSQL_COUNT" -gt 0 ]
then
    pass
    HIVE_COUNT=$HIVE_COUNT_MARK
    add_marks $HIVE_COUNT_MARK
    write_report "Hive Record Count        : PASS ($HIVE_COUNT_MARK/$HIVE_COUNT_MARK)"
else
    fail
    write_report "Hive Record Count        : FAIL (0/$HIVE_COUNT_MARK)"
fi

###############################################################################
# Grade Calculation
###############################################################################

if [ $TOTAL -ge 95 ]
then
    GRADE="A+"
elif [ $TOTAL -ge 90 ]
then
    GRADE="A"
elif [ $TOTAL -ge 80 ]
then
    GRADE="B+"
elif [ $TOTAL -ge 70 ]
then
    GRADE="B"
elif [ $TOTAL -ge 60 ]
then
    GRADE="C"
elif [ $TOTAL -ge 50 ]
then
    GRADE="D"
else
    GRADE="FAIL"
fi

###############################################################################
# Auto Feedback
###############################################################################

echo "" >> "$REPORT_FILE"
echo "==============================================================" >> "$REPORT_FILE"
echo "FEEDBACK" >> "$REPORT_FILE"
echo "==============================================================" >> "$REPORT_FILE"

if [ $JAVA -eq 0 ]; then
echo "- Install Java correctly." >> "$REPORT_FILE"
fi

if [ $PYTHON -eq 0 ]; then
echo "- Install Python 3." >> "$REPORT_FILE"
fi

if [ $HADOOP -eq 0 ]; then
echo "- Hadoop installation not detected." >> "$REPORT_FILE"
fi

if [ $MYSQL -eq 0 ]; then
echo "- Install or start MySQL Server." >> "$REPORT_FILE"
fi

if [ $SQOOP -eq 0 ]; then
echo "- Install Apache Sqoop." >> "$REPORT_FILE"
fi

if [ $HIVE -eq 0 ]; then
echo "- Install Apache Hive." >> "$REPORT_FILE"
fi

if [ "$MYSQL_COUNT" -lt 1000 ]; then
echo "- Dataset contains less than 1000 records. Run weather_etl.py again." >> "$REPORT_FILE"
fi

if [ $HDFS_IMPORT -eq 0 ]; then
echo "- Execute Sqoop Import again." >> "$REPORT_FILE"
fi

if [ $HIVE_IMPORT -eq 0 ]; then
echo "- Execute Sqoop Hive Import again." >> "$REPORT_FILE"
fi

###############################################################################
# Final Report
###############################################################################

echo "" >> "$REPORT_FILE"
echo "==============================================================" >> "$REPORT_FILE"
echo "FINAL RESULT" >> "$REPORT_FILE"
echo "==============================================================" >> "$REPORT_FILE"

echo "Total Marks : $TOTAL / $TOTAL_MARKS" >> "$REPORT_FILE"
echo "Grade       : $GRADE" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

echo "Faculty Signature : _______________________" >> "$REPORT_FILE"

###############################################################################
# Update marks.csv
###############################################################################

echo "$ROLLNO,$STUDENT_NAME,$DIVISION,$BATCH,$EXPERIMENT_NO,$TOTAL,$GRADE,$DATE" >> "$CSV_FILE"

###############################################################################
# Final Screen Output
###############################################################################

clear

echo -e "${GREEN}"
echo "=============================================================="
echo "        EXPERIMENT 05 EVALUATION COMPLETED"
echo "=============================================================="
echo -e "${NC}"

echo "Student Name : $STUDENT_NAME"
echo "Roll Number  : $ROLLNO"
echo "Experiment   : $EXPERIMENT_NO"
echo

echo "Marks Obtained : $TOTAL / $TOTAL_MARKS"
echo "Grade          : $GRADE"
echo

echo "Report Generated : $REPORT_FILE"
echo "Marks Updated    : $CSV_FILE"

echo

if [ "$GRADE" = "A+" ]; then
    echo -e "${GREEN}Outstanding Performance!${NC}"
elif [ "$GRADE" = "A" ]; then
    echo -e "${GREEN}Excellent Work!${NC}"
elif [ "$GRADE" = "B+" ] || [ "$GRADE" = "B" ]; then
    echo -e "${YELLOW}Good Work. Minor Improvements Required.${NC}"
elif [ "$GRADE" = "C" ] || [ "$GRADE" = "D" ]; then
    echo -e "${YELLOW}Need More Practice.${NC}"
else
    echo -e "${RED}Experiment Incomplete. Please Reattempt.${NC}"
fi

echo
echo "=============================================================="

log "Evaluation Completed"

exit 0
