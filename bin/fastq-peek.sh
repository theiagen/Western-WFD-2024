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

#Calculate GC Percentage
##Count number of GCs
#{BASH-SCRIPT-TO-COUNT-GC}
GC_CONTENT=$(python3 - <<HEREDOC
import sys

def calculate_gc_content(FASTQ_FILE):
    with open(FASTQ_FILE, 'r') as file:
        content = file.read()
    
    GC_COUNT = sum(1 for base in content if base in 'GCgc')
    TOTAL_BASE_COUNT = sum(1 for base in content if base in 'ATCGNatcgn')
    
    GC_PERCENT = (GC_COUNT / TOTAL_BASE_COUNT * 100) if TOTAL_BASE_COUNT > 0 else 0
    return GC_PERCENT

FASTQ_FILE = "$FASTQ_FILE"
GC_PERCENT = calculate_gc_content(FASTQ_FILE)
print(f"{GC_PERCENT:.2f}")
HEREDOC
)

echo "Number of reads in $FASTQ_FILE: $READ_COUNT"
echo "GC content in $FASTQ_FILE: $GC_CONTENT%"
