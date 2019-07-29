#! /bin/bash

# A for loop to move a set of files from one directory to another

mkdir first_directory second_directory
cd first_directory
touch 1.txt 2.txt 3.txt
cd ..

for file in ./first_directory/*; do
        mv "$file" ./second_directory/
done
