#!/bin/bash

# OCR Script to convert PDF to text using pdftoppm and tesseract

# Function to display usage
usage() {
    echo "Usage: $0 input.pdf"
    exit 1
}

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: No input file provided."
    read -p "Please enter the name of the PDF file to OCR: " input
    if [ -z "$input" ]; then
        usage
    fi
else
    input="$1"
fi

# Check if the input file exists
if [ ! -f "$input" ]; then
    echo "Error: File '$input' not found."
    exit 1
fi

# Extract the base name without the extension
base_name=$(basename "$input" .pdf)

# Create a temporary directory for intermediate files
temp_dir=$(mktemp -d)
echo -e "\e[34mCreating a temporary directory for intermediate files...\e[0m"

# Convert PDF to PNG images
echo -e "\e[34mConverting PDF to PNG images...\e[0m"
pdftoppm -r 300 "$input" "$temp_dir/$base_name" -png &
spinner
echo -e "\e[32mConversion to PNG completed.\e[0m"

# Perform OCR on the PNG images and output to text files
echo "Performing OCR on PNG images..."
find "$temp_dir" -name "${base_name}*.png" -exec tesseract {} {}.txt \; &
spinner
echo "OCR process completed for all images."

# Concatenate all text files into one final output
echo "Concatenating text files into one final output..."
cat "$temp_dir/${base_name}"*.txt > "${base_name}_ocr.txt"
echo -e "\e[32mConcatenation completed.\e[0m"

# Clean up the intermediate image and text files
echo -e "\e[34mCleaning up intermediate files...\e[0m"
rm -r "$temp_dir"
echo -e "\e[32mCleanup completed.\e[0m"

# Notify the user of completion
echo "OCR process completed. The text is available in final_output.txt"
# Spinner animation
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Example usage of spinner:
# long_running_command &
# spinner
