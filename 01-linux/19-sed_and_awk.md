# Linux Text Processing: sed and awk

This section introduces two essential Linux text-processing tools: sed and awk. These tools are widely used in DevOps, cloud engineering, and system administration for processing logs, modifying configuration files, and automating data workflows.

- sed (Stream Editor) is used for modifying text  
- awk is used for analyzing and extracting structured data  

## sed – Stream Editor

### Description
sed is a command-line utility used to perform text transformations on an input stream (a file or piped input).


### Syntax
    sed 's/pattern/replacement/' file


### Common Operations

#### Replace first occurrence
    sed 's/nginx/apache/' file.txt

#### Replace all occurrences
    sed 's/nginx/apache/g' file.txt

#### Modify file in place
    sed -i 's/nginx/apache/g' file.txt

#### Delete lines containing a pattern
    sed '/error/d' logfile.log

#### Print specific lines
    sed -n '1,5p' file.txt

### Use Cases

- Updating configuration files  
- Cleaning log files  
- Automating text transformations in scripts  
- Replacing environment variables in CI/CD pipelines  


## awk – Text Processing Language

awk is a powerful tool for processing and analyzing structured text data. It works line by line and splits each line into fields.


### Syntax
    awk '{print $1}' file.txt


### Key Concepts

| Symbol | Meaning |
|--------|--------|
| $1     | First column |
| $2     | Second column |
| $0     | Entire line |


### Common Operations

#### Print a column
    awk '{print $1}' file.txt

#### Print multiple columns
    awk '{print $1, $3}' file.txt

#### Filter lines by pattern
    awk '/error/ {print}' logfile.log

#### Conditional filtering
    awk '$3 > 100 {print}' data.txt

#### Sum a column
    awk '{sum += $2} END {print sum}' file.txt


### Use Cases

- Parsing and analyzing logs  
- Extracting structured data  
- Monitoring system metrics  
- Processing CSV and tabular data  
- Building reporting scripts  


## sed vs awk

| Feature   | sed                  | awk                     |
|----------|----------------------|-------------------------|
| Purpose  | Modify text          | Analyze text            |
| Strength | Find and replace     | Column-based processing |
| Use Case | Editing files        | Data extraction         |


## Example: Log Processing

### Sample Log File
    192.168.1.1 GET 200
    192.168.1.2 POST 500
    192.168.1.3 GET 404


### Count failed requests (status >= 400)
    awk '$3 >= 400 {count++} END {print count}' logfile.log


### Replace error codes
    sed 's/500/ERROR/g' logfile.log


## Mini Project: Log Analyzer

### File
log_analyzer.sh


### Description
This script performs the following:

- Counts failed requests (status codes >= 400)  
- Extracts unique IP addresses  
- Masks IP addresses for privacy  


### Script
    #!/bin/bash

    LOGFILE="logfile.log"

    echo "---- Error Count ----"
    awk '$3 >= 400 {count++} END {print count}' $LOGFILE

    echo "---- Unique IPs ----"
    awk '{print $1}' $LOGFILE | sort | uniq

    echo "---- Masked Logs ----"
    sed -E 's/^([0-9]+\.[0-9]+)\.[0-9]+\.[0-9]+/\1.xxx.xxx/' $LOGFILE


### Execution
    chmod +x log_analyzer.sh
    ./log_analyzer.sh


## Example Pipeline

    cat logfile.log | grep "GET" | awk '{print $1}' | sort | uniq


## Sample Input and Output

### Input (logfile.log)
    192.168.1.1 GET 200
    192.168.1.2 POST 500
    192.168.1.3 GET 404
    192.168.1.1 GET 200


### Output
    ---- Error Count ----
    2

    ---- Unique IPs ----
    192.168.1.1
    192.168.1.2
    192.168.1.3

    ---- Masked Logs ----
    192.168.xxx.xxx GET 200
    192.168.xxx.xxx POST 500
    192.168.xxx.xxx GET 404
    192.168.xxx.xxx GET 200


## Key Takeaways

- sed is used for editing and transforming text  
- awk is used for analyzing structured data  
- Combining tools enables powerful data processing pipelines  


## DevOps Relevance

In production environments:

- Logs are large and continuous  
- Data needs to be processed quickly  
- Automation is critical  

Using sed and awk allows engineers to:

- Build efficient data pipelines  
- Debug systems faster  
- Automate repetitive tasks  
- Process logs without heavy tooling  

