#!/bin/bash

# A script to setup a bioinformatics project folder
# Wanyi Chen wchen98@jh.edu
# June 4th, 2019

# Setup folder structure
echo "Creating folder structure..."
mkdir code data data/raw_data output output/figures output/tables

# Download datafiles and processed with the raw data and export processed
# data to the data diretory.
echo "Downloading data files..."
cd data/raw_data

cd ..
cd ..
touch code/.gitkeep output/figures/.gitkeep output/tables/.gitkeep

echo "All done!"
