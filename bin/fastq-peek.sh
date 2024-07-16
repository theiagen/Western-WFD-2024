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


echo "extracting sequence lines"
SEQ_LINES=$(awk '/^@SEQ/ { getline; print }' "$FASTQ_FILE")

echo "calculating GC percent"
# Count number of bases
TOTAL_BASE_COUNT=$(echo -n "$SEQ_LINES" | tr -cd 'ATCGatcg' | wc -m)
# Count GC percent
GC_COUNT=$(echo -n "$SEQ_LINES" | tr -cd 'GCgc' | wc -m)
# Calculate GC Percent
GC_PERCENT=$(awk "BEGIN {print ($GC_COUNT / $TOTAL_BASE_COUNT) * 100}")

#print results
#echo "Number of bases in $FASTQ_FILE: $TOTAL_BASE_COUNT"
#echo "GC count in $FASTQ_FILE: $GC_COUNT"
echo "GC content in $FASTQ_FILE: $GC_PERCENT%"
