#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Check if a FASTQ file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <fastq_file>"
    exit 1
fi

FASTQ_FILE=$1

# Check if the provided file exists
if [ ! -f "$FASTQ_FILE" ]; then
    echo "Error: File '$FASTQ_FILE' not found!"
    exit 1
fi

echo "Processing FASTQ file: $FASTQ_FILE"

# Count number of reads in FASTQ file
## Count the number of lines in the FASTQ file
LINE_COUNT=$(wc -l < "$FASTQ_FILE")
## Calculate the number of reads (4 lines per read)
READ_COUNT=$((LINE_COUNT / 4))

echo "Number of reads in $FASTQ_FILE: $READ_COUNT"

# Calculate the percent GC content
cat ${FASTQ_FILE} \
     | paste - - - - \
     | cut -f 2 \
     | tr -d '\n\r\t ' \
     | sed -E 's/./&\n/g' \
     | awk -v fname=${FASTQ_FILE} -v ngc=0 -v tot=0 -v status='ok' '{char=toupper($1)}{if(char != "A" && char != "T" && char != "C" && char != "G" ) {status="not ok"; exit 1} else if (char == "C" || char == "G") {ngc++; tot++} else { tot++ } } END {if (status == "ok") {print "GC content in "fname": "100*ngc/tot"%"} else if (status == "not ok") {print "Error: "fname" contains unexpected characters."} }'