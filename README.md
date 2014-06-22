# Getting and Cleaning Data #

#Course Project#

## Project Description ##

This project takes a data set from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and processes it to obtain a tidy dataset that contains the average of the means and standard deviations of the measurements from the original dataset.  

## Contents ##

This repository contains 3 files:

- README.md: This file with information about the project
- run\_analysis.R: Contains the code to processes the file from the dataset and outputs a tidy dataset with the average of the means and standard deviations of the measurements of the original files.
- CodeBook.md: A code book that describes the variables, the data, and any transformations or work performed on the data

## Requirements ##
The script contained in the run_analysis.R file use the [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "Human Activity Recognition Using Smartphones") dataset. The file [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "getdata-projectfiles-UCI HAR Dataset.zip") should be downloaded and opened in the same directory as the R file, so that the "UCI HAR Dataset" directory is at the same level as the script. This dataset is not included in this git repository.
The folder structure should be:

- run_analysis.R
- UCI HAR Dataset
 - activity_labels.txt
 - features.txt
 - features_info.txt
 - test
 - train

The run\_analysis.R scriptfirst checks if the "UCI HAR Dataset" directory exists in the working directory, if not it will exit with the error message **"Unable to find UCI HAR Dataset directory"**.

## Running the analysis ##
To run the analysis, make sure you set your working directory in R to a directory that contains both the run\_analysis.R file and the "UCI HAR Dataset" directory. Then load the R script using the command:

    > source("run_analysis.R")

Once the script is loaded it will run the commands and generate and output file in the working directory called **"dataset.txt"** and will save the dataset in a dataframe called **tidy\_data**. You can then process the **tidy\_data** dataframe for further analysis.

For reference, the code takes approximately 22 seconds to run on an computer with an Intel i7 4770 3.4GHz CPU, 8GB of RAM and a 7200RPM mechanical hard drive. 

## Output ##

The run\_analysis script creates a new dataframe called **tidy\_data** with 180 rows and 68 columns that contain the subjectid, activity and the average of the means and standard deviations for several fields (as detailed in the CookBook.md file) from the original **"Human Activity Recognition Using Smartphones"** dataset. It will also save the **tidy\_data** dataframe to a new file called **"dataset.txt"** in the working directory. If there is already a file with that name in the directory, it will be overwritten.

## Analysis Details ##
### Assumptions ###
- One of the tasks to perform in the assignment was **"Extracts only the measurements on the mean and standard deviation for each measurement."**. It was assumed that only the columns with the strings "mean()" and "std()" comply with this requirement. Other columns that contained strings such as "meanFreq()" were not considered to be measurements on the mean or standard deviation.

### Variable renaming ###
Task 4 of the assignment is to "Appropriately labels the data set with descriptive variable names.".
This task is performed using the **create\_new\_name(name)** function in the R script. The function processes a string with the name of the column and outputs a more descriptive name, based on the recommendations from the "Editing Text Variables" lecture, on slide 16, which states:

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

In order to create the outputs (**tidy\_data** dataframe and **dataset.txt** file) the following process was performed on the input dataset:

1. First the input files (subject\_test.txt,x\_test.txt, y\_test.txt from the test directory, and subject\_train.txt, x\_train.txt, y\_train.txt from the train directory) were loaded using read.table.
2. Once loaded, they were combined into three datasets:
	- One combining the data from subject\_test.txt and subject\_train.txt
	- One combining the data from x\_test.txt and x\_train.txt
	- One combining the data from y\_test.txt and y\_train.txt
3. Next step is to convert the activities from the y_*.txt files into their proper names from the "activity_labels.txt" file. With this we achieved the "Uses descriptive activity names to name the activities in the data set" step in the assignment. This was done by converting the numbers in the "y" dataset to a factor, and then assigning the level names to those factors based on the information from the "activity_labels.txt" file.
4. Then all the three datasets were combined into one merged dataset by appending the columns of all three datasets from point 2 using cbind().
5. In order to rename the columns to their original name, the names were loaded from the "features.txt" file into a vector, and this vector was used as the column names. In addition the columns from the "y" dataset and the "x" dataset were named "subjectid" and "activity".
6. In order to extract only the measurements on the mean and standard deviation for each measurement a regular expression was used that looked for columns that have the strings mean() or std() and filter out the remaining columns. It uses the grep function on the column names. Once the columns with mean() or std() are identified, a new dataframe is created with only these columns (plus the "subjectid" and "activity" columns).
7. At this point it is necessary to label the columns with descriptive variable names. This process is described in the section **"Variable renaming"** above.
8. The final step is to create a dataset with the average of the means and standard deviations of each variable for each activity and each subject. This is done using the [aggregate() function](http://www.statmethods.net/management/aggregate.html).
9. And finally the columns are renamed to reflect the fact that they now contain the average of the mean and standard deviation, not the actual mean and standard deviation. This is achieved by adding "average" to the beginning of the columns. For example the column "timebodyaccelerometermeanx" will be renamed to "averagetimebodyaccelerometermeanx".

### Output dataframe ###
The output dataframe contains 68 columns and 180 rows. The first column has the subject ID from the subject\_test.txt and subject\_train.txt files. The second column contains the names of the activities performed, from the y\_test.txt and y\_train.txt files, renamed to match the names from the 
"activity_labels.txt" file. The remaninig columns contain the average of the means and standard deviations from the data from the different signals originally contained in the x\_test.txt and x\_train.txt files.

"subjectid" | "activity" | "averagetimebodyaccelerometermeanx" | "averagetimebodyaccelerometermeany" | "averagetimebodyaccelerometermeanz" | ... 
------------|------------|-------------------------------------|-------------------------------------|-------------------------------------|----
1 | "WALKING" | 0.277330758736842 | -0.0173838185273684 | -0.111148103547368 | ...
2 | "WALKING" | 0.276426586440678 | -0.0185949199145763 | -0.105500357966102 | ...
3 | "WALKING" | 0.275567462068966 | -0.0171767844203448 | -0.112674859827586 | ...
  