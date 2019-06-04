#!/bin/bash

# A script to setup a bioinformatics project folder
# Wanyi Chen wchen54@dons.usfca.edu
# September 9th, 2017

# Setup folder structure
echo "Creating folder structure..."
mkdir code data data/raw_data output output/figures output/tables

echo "Downloading data files..."
cd data/raw_data
# Download datafiles and processed with the raw data and export processed 
# data to the data diretory.

cd ..
cd ..
touch code/.gitkeep output/figures/.gitkeep output/tables/.gitkeep

echo "All done!"
