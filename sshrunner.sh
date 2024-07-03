#!/bin/bash

# ASCII art
cat << "EOF"
   =/\                 /\=
    / \'._   (\_/)   _.'/ \
   / .''._'--(o.o)--'_.''. \
  /.' _/ |`'=/ " \='`| \_ `.\
 /` .' `\;-,'\___/',-;/` '. '\
/.-' sp   `\(-V-)/`       `-.\
`            "   "            `
EOF

# Author Name and Version
echo "Author: Sebastian Pina"
echo "Version: 1.0"
echo

# Prompt for the IP list file
read -ep "Enter the IP list file: " IP_LIST_FILE

# Define the output file
OUTPUT_FILE="ssh-output"

# Check if the IP list file exists
if [[ ! -f "$IP_LIST_FILE" ]]; then
  echo "IP list file not found: $IP_LIST_FILE"
  exit 1
fi

# Loop through each IP address in the list
while IFS= read -r IP; do
  if [[ -n "$IP" ]]; then
    # Print the current IP being processed
    echo "Processing IP: $IP"
    echo "------------------------------------------" >> "$OUTPUT_FILE"
    echo "IP: $IP" >> "$OUTPUT_FILE"
    echo "------------------------------------------" >> "$OUTPUT_FILE"
    # Run ssh-audit.py and capture colored output
    unbuffer ./ssh-audit.py "$IP" | tee -a "$OUTPUT_FILE"
    # Add a separator between outputs for clarity
    echo -e "\n---\n" >> "$OUTPUT_FILE"
  fi
done < "$IP_LIST_FILE"

echo "SSH Audit Completed"
