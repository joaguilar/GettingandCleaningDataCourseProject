# Getting and Cleaning Data #

#Course Project#

## Project Description ##

This project takes a data set from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and processes it to obtain a tidy dataset that contains the average of the means and standard deviations of the measurements from the original dataset.  

## Contents ##

This repository contains 3 files:

- README.md: This file with information about the project
- run\_analysis.R: Contains the run\_analysis() function, which processes the file from the dataset and outputs a tidy dataset with the average of the means and standard deviations of the measurements of the original files.
- CodeBook.md: A code book that describes the variables, the data, and any transformations or work performed on the data

## Requirements ##
The functions contained in the run_analysis.R have a strong dependency on the [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "Human Activity Recognition Using Smartphones") dataset. The file [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "getdata-projectfiles-UCI HAR Dataset.zip") should be downloaded and opened in the same directory as the R file, so that the "UCI HAR Dataset" directory is at the same level as the script. This dataset is not included in this git repository.
The folder structure should be:

- run_analysis.R
- UCI HAR Dataset
 - activity_labels.txt
 - features.txt
 - features_info.txt
 - test
 - train

The run\_analysis() function first checks if the "UCI HAR Dataset" directory exists in the working directory, if not it will exit with the error message *"Unable to find UCI HAR Dataset directory"*.

## Running the analysis ##
To run the analysis, make sure you set your working directory in R to a directory that contains both the run\_analysis.R file and the "UCI HAR Dataset" directory. Then load the R script using the command:

    > source("run_analysis.R")

Once the script is loaded, you can run the run\_analysis() function in one of two ways:



1. Call the function on its own. It will generate and output file in the working directory called "dataset.txt" and will output the dataset to the R console:

    > run_analysis()


2. Call the function and store the output to a dataframe. This way you can perform further analysis on the resulting dataset. This option will also create the "dataset.txt" file in the working directory.

    > df<-run_analysis() 
 
## Output ##

The run\_analysis() function creates a new dataframe with 180 rows and 68 columns that contain the subjectid, activity and the average of the means and standard deviations for several fields from the original **"Human Activity Recognition Using Smartphones"** dataset. It will return the dataframe as the output of the function and it will also save it to a new file called "dataset.txt" in the working directory. If there is already a file with that name in the directory, it will be overwritten.