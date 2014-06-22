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

The run\_analysis() function first checks if the "UCI HAR Dataset" directory exists in the working directory, if not it will exit with the error message **"Unable to find UCI HAR Dataset directory"**.

## Running the analysis ##
To run the analysis, make sure you set your working directory in R to a directory that contains both the run\_analysis.R file and the "UCI HAR Dataset" directory. Then load the R script using the command:

    > source("run_analysis.R")

Once the script is loaded it will run the commands and generate and output file in the working directory called **"dataset.txt"** and will save the dataset in a dataframe called **tidy\_data**. You can then process the **tidy\_data** dataframe for further analysis.

For reference, the code takes approximately 20 seconds to run on an computer with an Intel i7 4770 CPU, 8GB of RAM and a 7200RPM mechanical hard drive. 

## Output ##

The run\_analysis script creates a new dataframe called **tidy\_data** with 180 rows and 68 columns that contain the subjectid, activity and the average of the means and standard deviations for several fields (as detailed in the CookBook.md file) from the original **"Human Activity Recognition Using Smartphones"** dataset. It will also save the **tidy\_data** dataframe to a new file called **"dataset.txt"** in the working directory. If there is already a file with that name in the directory, it will be overwritten.

## Analysis Details ##
### Assumptions ###
- One of the tasks to perform in the assignment was **"Extracts only the measurements on the mean and standard deviation for each measurement."**. It was assumed that only the columns with the strings "mean()" and "std()" comply with this requirement. Other columns that contained strings such as "meanFreq()" were not considered to be measurements on the mean or standard deviation.

### Variable renaming ###
Task 4 of the assignment is to "Appropriately labels the data set with descriptive variable names.".
This is achieved in the script using the **create\_new\_name(name)** function in the R script. The function processes a string with the name of the column and outputs a more descriptive name, based on the recommendations from the "Editing Text Variables" lecture, on slide 16, which states:

     Names of variables should be
      - All lower case when possible
      - Descriptive (Diagnosis vs Dx)
      - Not duplicated
      - Not have underscores or dots or white spaces

Based on the names of the columns in the original dataset, there are 6 pieces of information in the name, which are used by the function for renaming:

1. **Time or Frequency**: If the columns starts with "t" or "f", it then gets renamed to "time" "frequency" as appropriate.
2. **Body or Gravity**: The second part of the name is either "Body" or "Gravity". These are mostly kept as it is already a full descriptive word
3. **Accelerometer or Gyroscope**: The next part of the name is the sensor from which the data comes from, in this case the "Gyroscope" or the "Accelerometer". The full word is expanded from the abbreviations used in the original name.
4. **Jerk and Magnitude**: The Jerk signals are already descriptive, so the word is kept. "Mag" is expanded to "magnitude".  
5. **Mean or Standard Deviation**: The original data set contains several additional functions, but after keeping only the mean and standard deviation it is only necessary to rename these two functions from "mean" to "mean" and "std" to "standarddeviation"
6. **X, Y or Z**. Finally we need to keep the axis in which the signal was collected. This is kept as is, only modified to be lower case: "X"->"X", "Y"->"Y", "Z"->"Z"

All underscores, dashes and parenthesis are removed from the name.
As an example the original column:

    tBodyAcc-mean()-X

will end up being named: 

    timebodyaccelerometermeanx

### Data set processing ###
In 