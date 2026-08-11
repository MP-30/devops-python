#!/bin/bash

LOG_FILE="access.log"
awk '$9 >= 500 && $9 < 600 {print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5


## 1. awk '$9 >= 500 && $9 < 600 {print $1}' "$LOG_FILE"

##* $9 (Status Code): In a standard Nginx log format, the 9th column represents the HTTP status code (e.g., 200, 404, 503).
#* $9 >= 500 && $9 < 600: This filters for HTTP 5xx Server Error codes (like 500 Internal Server Error or 502 Bad Gateway).
#* {print $1}: For every matching log line, it extracts and prints the 1st column, which is the client's IP address. [1, 2, 3, 4]

## 2. sort

#* Groups identical IP addresses together in alphabetical/numerical order. This step is mandatory because the next command (uniq) can only count duplicates if they are adjacent to each other. [5, 6]

## 3. uniq -c
#
#* Collapses consecutive identical lines into a single line.
#* -c (Count): Prefixes each unique IP address with the number of times it appeared (e.g., 142 192.168.1.5). [7, 8]
#
### 4. sort -nr
#
#* Sorts the aggregated list based on the error count.
#* -n (Numeric): Tells sort to evaluate the counts as numbers (otherwise 10 would sort before 2).
#* -r (Reverse): Sorts in descending order, placing the highest error-generating IPs at the top. [9, 10, 11, 12, 13]
#
### 5. head -5
#
#* Slices the output to only return the top 5 rows from the results.
#
