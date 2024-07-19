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

echo: "Number of reads in $FASTQ_FILE: $READ_COUNT"

#Calculate GC %
##Count Number of GC and assign to "GC_COUNT"
GC_COUNT=$(grep -E '^[ATCGN]+$' $FASTQ_FILE | tr -cd 'GCgc' | wc -c)

##Count total nucleotides and assign to "TOTAL_BASE_COUNT"
TOTAL_BASE_COUNT=$(grep -E '^[ATCGN]+$' $FASTQ_FILE | tr -cd 'ATGCatgc' | wc -c)

##Calculate % GC out of all nucelotides and assign to "GC PERCENT"
GC_PERCENT=$(awk "BEGIN {print ($GC_COUNT / $TOTAL_BASE_COUNT) * 100}")

echo 'GC content in $FASTQ_FILE: $GC_CONTENT%'