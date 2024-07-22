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

##Count A, C, T, and G nucleotides in reads
TOTAL_BASE_COUNT=$(grep -E '^[ACTG]+$' $FASTQ_FILE | wc -c)

##Count G and C nucleotides in reads
GC_COUNT=$(grep -E '^[ACTG]+$' $FASTQ_FILE | sed 's/[AT]//g' | wc -c)

##Calculate GC Content of reads (X100 for % of total nts)
GC_CONTENT=$(awk "BEGIN {print ($GC_COUNT / $TOTAL_BASE_COUNT) * 100}")

echo "Number of reads in $FASTQ_FILE: $READ_COUNT"
echo "GC Content in $FASTQ_FILE: $GC_CONTENT%"