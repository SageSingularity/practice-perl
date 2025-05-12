#!/bin/bash

# Use strict mode to catch common errors
set -euo pipefail # This line sets the script to exit immediately if any command returns a non-zero exit status, and it also prevents the script from using undefined variables.
IFS=$'\n\t' # This line sets the Internal Field Separator (IFS) to a newline and tab character, which is used to split strings into arrays.

# 1. Define the file we'll work with
filename="example.txt" # This line defines the filename variable, which is the name of the file we'll work with.

# 2. Check if the file exists
if [[ -f "$filename" ]]; then # This line checks if the file exists.
  echo "Reading contents of '$filename':" # This line prints a message to the console indicating that we're reading the contents of the file.

  # Read the file line by line
  while IFS= read -r line; do # This line reads the file line by line.
    echo "$line" # This line prints each line to the console.
  done < "$filename" # This line reads the file line by line.
else
  echo "File '$filename' not found. Creating it now..." # This line prints a message to the console indicating that the file does not exist.

  # Create the file and write some sample content
  echo -e "This is an example file.\nIt contains multiple lines.\nHere is a line with the word 'Perl'." > "$filename" # This line creates the file and writes some sample content to it.

  echo "File created. Run the script again to read its contents." # This line prints a message to the console indicating that the file has been created.
fi

# 3. Search the file for lines containing a keyword
echo -e "\nSearching for lines containing the word 'Perl':"
grep "Perl" "$filename" || echo "No matches found."

# 4. List all non-directory files in the current directory
echo -e "\nListing files in the current directory:"
ls -p | grep -v /

# 5. These open a file using a terminal interface that allows us to edit the file
#echo -e "\nOpening '$filename' with the default system program..."
#if command -v less > /dev/null; then
#  less "$filename"  # Read-only viewer
#elif command -v nano > /dev/null; then
#  nano "$filename"  # Simple terminal editor
#elif command -v vi > /dev/null; then
#  vi "$filename"    # Vi editor fallback
#else
#  echo "No terminal file viewer/editor (less, nano, vi) is available."
#fi

# 6. Show basic statistics about the file (lines, words, characters)
echo -e "\nRunning word count on '$filename':"
wc "$filename" # wc (Word Count) is a command that counts the number of lines, words, and characters in a file

# 7. Print the current date and working directory using command substitution
echo -e "\nCurrent date and time: $(date)"
echo "Current working directory: $(pwd)"

# Done
echo -e "\nScript complete."
