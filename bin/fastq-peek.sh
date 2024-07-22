#!/bin/bash

# Holly Halstead 
# Western-WFD-2024 Week 01 Exercise

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
## Count GC in FASTQ file
GC_COUNT=$(awk '(NR%4==2) {gsub(/[ATnNat]/,"");N+=length($0);}END{print N;}' "$FASTQ_FILE")
## Count total number of bases in FASTQ file
TOTAL_BASE_COUNT=$(awk 'NR%4==2 {sum += length($0)} END {print sum}' "$FASTQ_FILE")
## Calculate GC percent in FASTQ file
GC_PERCENT=$(awk '(NR%4==2) {N1+=length($0);gsub(/[AT]/,"");N2+=length($0);}END{print N2/N1;}' "$FASTQ_FILE")

# Print results to terminal
echo -e "Number of reads in $FASTQ_FILE: $READ_COUNT\nGC Percent in $FASTQ_FILE: $GC_PERCENT"

exit 0
