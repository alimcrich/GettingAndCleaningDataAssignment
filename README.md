## README

This document describes the content of this repository. It will also provide instructions on how to run the R script to transform some raw data to a tidy data set. This is a programming assignment for the Coursera course 'Getting and Cleaning Data' and the assignment page can be found [here](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).

## Contents

This section describes the contents of this repository.

| Filename | Description |
|---------|---------|
|README.md| This file|
|Codebook.md| Describes the variables in the tidy data set and the transformations undertaken to achieve the tidy data set|
| run_analysis.R | R script to obtain the raw dataset, transform it and save to csv and txt files |
| tidy_data.txt | TXT file of tidy dataset|
| tidy_data.csv | CSV file of tidy dataset |
| .gitignore | file to ignore files |

## Setup
Before running the script, the following steps have to be completed:

* The R environment is installed
* The package 'reshape2' needs to be installed
* It is assumed that the directory structure and file names of the extracted files follows that of the origin ZIP file

## How to run the Script
To transform the raw data into the tidy data, follow these steps:

1. Source run_analysis.R and run the function
```
source('<your default R working directory>/run_analysis.R'))
```
2. Once the function has completed running, you will see two output files - "tidy_data.csv" and "tidy_data.txt" - in your working directory. These files contain the same data and are presented in CSV and TXT formats.
3. To read the files into R:
```
# Read text file
read.table("tidied_data.txt", header=TRUE)
# Read csv file
read.csv("tidied_data.csv", header=TRUE)
```