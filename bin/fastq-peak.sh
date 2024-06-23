#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Source the library file for reusable functions
source "$SCRIPT_DIR/../lib/utils.sh"

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

# Count the number of reads in the FASTQ file #
# Count the number of lines in the FASTQ file
LINE_COUNT=$(wc -l < "$FASTQ_FILE")
#Calculate the number of reads (4 lines per read)
READ_COUNT=$((LINE_COUNT / 4))
# Output the number of reads
echo "Number of reads in $FASTQ_FILE: $READ_COUNT"

