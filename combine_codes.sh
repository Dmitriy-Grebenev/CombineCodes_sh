#!/bin/bash

# Output file name
output_file="combined_codes.txt"

# Clear the output file if it exists
> "$output_file"

# Function to process files
process_file() {
    local file="$1"
    local extension="${file##*.}"
    
    # Check if the file is a text or source code file based on extension
    if [[ "$extension" =~ ^(java|py|cpp|c|h|hpp|js|html|css|php|rb|go|rs|sh|txt|ts)$ ]]; then
        echo "=== File: $file ===" >> "$output_file"
        cat "$file" >> "$output_file"
        echo -e "\n\n" >> "$output_file"
    fi
}

# Recursively traverse all files in the current directory and subdirectories
while IFS= read -r -d '' file; do
    process_file "$file"
done < <(find . -type f -print0)

echo "All code files have been combined into: $output_file"
