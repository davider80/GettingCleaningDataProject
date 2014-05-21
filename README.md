GettingCleaningDataProject
==========================

## Description

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The run_analysis.R script perform the following actions on the data collected from the accelerometers from the Samsung Galaxy S smartphone:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

More information in the [codebook](Codebook.md) 

## Script usage instructions

1. Download the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Unzip the content of the zip file in a directory named: `data`
3. Place the `run_analysis.R` in the parent directory
4. Run the `run_analysis.R` script
5. The script will create the tidy data file named `tidy.txt`
