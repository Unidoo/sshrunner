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
echo "Version: 1.1"
echo

# Prompt for the IP list file
echo -n "Enter the IP list file: "
read IP_LIST_FILE

# Define the output file
OUTPUT_FILE="ssh-output"
WEAK_SSH_FILE="weakssh-hosts.txt"

# Check if the IP list file exists
if [ ! -f "$IP_LIST_FILE" ]; then
  echo "IP list file not found: $IP_LIST_FILE"
  exit 1
fi

# Initialize the count of weak SSH IPs
weak_ssh_count=0

# Loop through each IP address in the list
while IFS= read -r IP; do
  if [ -n "$IP" ]; then
    # Print the current IP being processed
    echo "Processing IP: $IP"
    echo "------------------------------------------" >> "$OUTPUT_FILE"
    echo "IP: $IP" >> "$OUTPUT_FILE"
    echo "------------------------------------------" >> "$OUTPUT_FILE"
    
    # Run ssh-audit.py and capture the output
    audit_output=$(unbuffer ./ssh-audit.py "$IP")
    echo "$audit_output" | tee -a "$OUTPUT_FILE"
    
    # Check for weak SSH indication
    echo "$audit_output" | grep -q "using weak elliptic curves"
    if [ $? -eq 0 ]; then
      weak_ssh_count=$((weak_ssh_count + 1))
      echo "$IP" >> "$WEAK_SSH_FILE"
    fi
    
    # Add a separator between outputs for clarity
    echo -e "\n---\n" >> "$OUTPUT_FILE"
  fi
done < "$IP_LIST_FILE"

# Print the final count of weak SSH IPs
echo "SSH Audit Completed"
echo "Number of IPs using weak elliptic curves: $weak_ssh_count"
