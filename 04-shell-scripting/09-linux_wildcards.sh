#!/bin/bash
######################################
# Author : Roy Ivia
# Date   : 07/04/2026
#
# This script demonstrates Linux wildcards (globbing).
# It creates 50 sample files and runs 15 wildcard examples,
# showing how to list, match, and filter files using *, ?, [], and [^].
#
# Version: V1
######################################

# Create a test directory
mkdir -p wildcard_lab
cd wildcard_lab || exit

# Create 50 sample files
touch file1.txt file2.txt fileA.txt fileB.txt fileC.txt \
      test1.log test2.log data1.csv data2.csv data3.csv \
      script1.sh script2.sh script3.sh script4.sh \
      gamer ghost grape gnose gonzp guyak gumpy \
      mkfile mkdocs mkdata mktest mkfinal \
      alpha beta gamma delta epsilon zeta eta theta \
      one1 two2 three3 four4 five5 six6 seven7 eight8 nine9 ten10 \
      hidden1.txt .hidden2.txt .config .env \
      apple banana cherry date elderberry fig grape1 grape2

echo "50 sample files created."

# Wildcard Examples

echo -e "\n1. List all files including hidden"
ls -a

echo -e "\n2. List files starting with 'g' and exactly 5 letters"
ls g????

echo -e "\n3. List files starting with 'mk'"
ls mk*

echo -e "\n4. List files 5 letters, starting with 'g', second letter a–n"
ls g[a-n]???

echo -e "\n5. List files 5 letters, starting with 'g', second letter NOT a–m"
ls g[^a-m]???

echo -e "\n6. List all .txt files"
ls *.txt

echo -e "\n7. List all .sh files"
ls *.sh

echo -e "\n8. List files ending with numbers"
ls *[0-9]*

echo -e "\n9. List files with names 6 characters long"
ls ??????

echo -e "\n10. List files starting with 'file' and ending with .txt"
ls file*.txt

echo -e "\n11. List files containing 'data'"
ls *data*

echo -e "\n12. List files not ending with .txt"
ls *[^t][^x][^t]

echo -e "\n13. List hidden files only"
ls .*

echo -e "\n14. List files starting with vowels (a, e, i, o, u)"
ls [aeiou]*

echo -e "\n15. List files not starting with vowels"
ls [^aeiou]*

echo -e "\nWildcard demonstration complete."

