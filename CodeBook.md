# Getting and Cleaning Data #

# Course Project - Code Book #

This code book indicates all the variables and summaries calculated, along any other relevant information.

## Original Dataset Information ##
### Files ###
The original dataset used for this analysis is from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "Human Activity Recognition Using Smartphones"). The file **"getdata-projectfiles-UCI HAR Dataset.zip"** was downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "getdata-projectfiles-UCI HAR Dataset.zip").

From the README.txt file in the dataset:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
 
This zip file was expanded and uses as an input for the analysis. This zip file contains the following files that are relevant for the analysis:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The x\_*.txt files contain signals obtained from the data from the experiments. From the features_info.txt file:

 > These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag
> 
> The set of variables that were estimated from these signals are: 
> 
> mean(): Mean value
> std(): Standard deviation
> mad(): Median absolute deviation 
> max(): Largest value in array
> min(): Smallest value in array
> sma(): Signal magnitude area
> energy(): Energy measure. Sum of the squares divided by the number of values. 
> iqr(): Interquartile range 
> entropy(): Signal entropy
> arCoeff(): Autorregresion coefficients with Burg order equal to 4
> correlation(): correlation coefficient between two signals
> maxInds(): index of the frequency component with largest magnitude
> meanFreq(): Weighted average of the frequency components to obtain a mean frequency
> skewness(): skewness of the frequency domain signal 
> kurtosis(): kurtosis of the frequency domain signal 
> bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
> angle(): Angle between to vectors.
> 
> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
> 
> gravityMean
> tBodyAccMean
> tBodyAccJerkMean
> tBodyGyroMean
> tBodyGyroJerkMean

All in total, the x\_*.txt files contain 561 variables that correspond to 10299 observations, 2947 in the "x\_text.txt" file and 7352 in the "x\_train.txt" file.   

## Dataset Processing ##

### Data Merge ###
The data from the six files included in the zip files were merged together into one large dataset with 10299 rows and 563 columns. To achieve these, three intermediate datasets were created:

- One combining the data from subject\_test.txt and subject\_train.txt
- One combining the data from x\_test.txt and x\_train.txt
- One combining the data from y\_test.txt and y\_train.txt

Using those three datasets the full merged dataset was created with the following structure:

- **Column 1**: Named "subjectid", it contains the subject id from the first dataset that contained data from the subject\_test.txt and subject\_train.txt files.
- **Column 2**: Named "activity", it contains the activity performed during the observation. This comes from the dataset that contained data from the y\_test.txt and y\_train.txt files. In addition the activities were renamed according to the id/name pairs in the "activity_labels.txt" file.
- **Columns 3-563**: Correspond to the 561 columns in the x\_test.txt and x\_train.txt files. Thet are named using the column/names mapping from the "features.txt" file.

### Data filtering ###
For the output dataset we only need information about columns that contain the mean or standard deviation. To perform this filtering, a regular expression was used to look for columns that have the strings mean() or std() and filtered out the remaining columns. It uses the grep function on the column names. Once the columns with mean() or std() are identified, a new dataframe is created with only these columns (plus the "subjectid" and "activity" columns). Other columns that contained strings such as "meanFreq()" were not considered to be measurements on the mean or standard deviation.

This left the dataset with 68 columns:

- **Column 1**: "subjectid" as in the previous dataset.
- **Column 2**: "activity" as in the previous dataset.
- **Columns 3-68**: Correspond to 66 columns with the mean or standard deviation of a measurement. For details on which columns are included, see section **Column Descriptions** at the end of this file.


### Column Renaming ###
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

In the final dataset, since it contains the average of the means and standard deviations, the prefix "average" was used on these columns.

### Summarization ###
The output dataset contains the average of the means and standard deviations grouped by subject and activity. The "R" function aggregate() was used to aggregate the data by subject and activity.

The resulting dataset contains 180 rows, which corresponds to 30 subjects with 6 activities each, and 68 columns, one for the subject id, one for the activity, and 66 averages of either means or standard deviations from the original data.


## Output Dataset Column Descriptions ##

Variables | Description
----------|------------
subjectid | A number from 1 to 30 that represents the volunteer from which the observation was made.
activity | The activity performed by the volunteer for this observation. Can be one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
timebodyaccelerometermeanx | Average of the means for the subject and activity for the original variable named "tBodyAcc-mean()-X", grouped by subject and activity
timebodyaccelerometermeany | Average of the means for the subject and activity for the original variable named "tBodyAcc-mean()-Y", grouped by subject and activity
timebodyaccelerometermeanz | Average of the means for the subject and activity for the original variable named "tBodyAcc-mean()-Z", grouped by subject and activity
timebodyaccelerometerstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "tBodyAcc-std()-X", grouped by subject and activity
timebodyaccelerometerstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "tBodyAcc-std()-Y", grouped by subject and activity
timebodyaccelerometerstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "tBodyAcc-std()-Z", grouped by subject and activity
timegravityaccelerometermeanx | Average of the means for the subject and activity for the original variable named "tGravityAcc-mean()-X", grouped by subject and activity
timegravityaccelerometermeany | Average of the means for the subject and activity for the original variable named "tGravityAcc-mean()-Y", grouped by subject and activity
timegravityaccelerometermeanz | Average of the means for the subject and activity for the original variable named "tGravityAcc-mean()-Z", grouped by subject and activity
timegravityaccelerometerstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "tGravityAcc-std()-X", grouped by subject and activity
timegravityaccelerometerstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "tGravityAcc-std()-Y", grouped by subject and activity
timegravityaccelerometerstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "tGravityAcc-std()-Z", grouped by subject and activity
timebodyaccelerometerjerkmeanx | Average of the means for the subject and activity for the original variable named "tBodyAccJerk-mean()-X", grouped by subject and activity
timebodyaccelerometerjerkmeany | Average of the means for the subject and activity for the original variable named "tBodyAccJerk-mean()-Y", grouped by subject and activity
timebodyaccelerometerjerkmeanz | Average of the means for the subject and activity for the original variable named "tBodyAccJerk-mean()-Z", grouped by subject and activity
timebodyaccelerometerjerkstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "tBodyAccJerk-std()-X", grouped by subject and activity
timebodyaccelerometerjerkstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "tBodyAccJerk-std()-Y", grouped by subject and activity
timebodyaccelerometerjerkstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "tBodyAccJerk-std()-Z", grouped by subject and activity
timebodygyroscopemeanx | Average of the means for the subject and activity for the original variable named "tBodyGyro-mean()-X", grouped by subject and activity
timebodygyroscopemeany | Average of the means for the subject and activity for the original variable named "tBodyGyro-mean()-Y", grouped by subject and activity
timebodygyroscopemeanz | Average of the means for the subject and activity for the original variable named "tBodyGyro-mean()-Z", grouped by subject and activity
timebodygyroscopestandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyro-std()-X", grouped by subject and activity
timebodygyroscopestandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyro-std()-Y", grouped by subject and activity
timebodygyroscopestandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyro-std()-Z", grouped by subject and activity
timebodygyroscopejerkmeanx | Average of the means for the subject and activity for the original variable named "tBodyGyroJerk-mean()-X", grouped by subject and activity
timebodygyroscopejerkmeany | Average of the means for the subject and activity for the original variable named "tBodyGyroJerk-mean()-Y", grouped by subject and activity
timebodygyroscopejerkmeanz | Average of the means for the subject and activity for the original variable named "tBodyGyroJerk-mean()-Z", grouped by subject and activity
timebodygyroscopejerkstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyroJerk-std()-X", grouped by subject and activity
timebodygyroscopejerkstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyroJerk-std()-Y", grouped by subject and activity
timebodygyroscopejerkstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "tBodyGyroJerk-std()-Z", grouped by subject and activity
timebodyaccelerometermagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyAccMag-mean()", grouped by subject and activity
timebodyaccelerometermagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyAccMag-std()", grouped by subject and activity
timegravityaccelerometermagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "tGravityAccMag-mean()", grouped by subject and activity
timegravityaccelerometermagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "tGravityAccMag-std()", grouped by subject and activity
timebodyaccelerometerjerkmagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyAccJerkMag-mean()", grouped by subject and activity
timebodyaccelerometerjerkmagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyAccJerkMag-std()", grouped by subject and activity
timebodygyroscopemagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyGyroMag-mean()", grouped by subject and activity
timebodygyroscopemagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyGyroMag-std()", grouped by subject and activity
timebodygyroscopejerkmagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyGyroJerkMag-mean()", grouped by subject and activity
timebodygyroscopejerkmagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "tBodyGyroJerkMag-std()", grouped by subject and activity
frequencybodyaccelerometermeanx | Average of the means for the subject and activity for the original variable named "fBodyAcc-mean()-X", grouped by subject and activity
frequencybodyaccelerometermeany | Average of the means for the subject and activity for the original variable named "fBodyAcc-mean()-Y", grouped by subject and activity
frequencybodyaccelerometermeanz | Average of the means for the subject and activity for the original variable named "fBodyAcc-mean()-Z", grouped by subject and activity
frequencybodyaccelerometerstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "fBodyAcc-std()-X", grouped by subject and activity
frequencybodyaccelerometerstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "fBodyAcc-std()-Y", grouped by subject and activity
frequencybodyaccelerometerstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "fBodyAcc-std()-Z", grouped by subject and activity
frequencybodyaccelerometerjerkmeanx | Average of the means for the subject and activity for the original variable named "fBodyAccJerk-mean()-X", grouped by subject and activity
frequencybodyaccelerometerjerkmeany | Average of the means for the subject and activity for the original variable named "fBodyAccJerk-mean()-Y", grouped by subject and activity
frequencybodyaccelerometerjerkmeanz | Average of the means for the subject and activity for the original variable named "fBodyAccJerk-mean()-Z", grouped by subject and activity
frequencybodyaccelerometerjerkstandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "fBodyAccJerk-std()-X", grouped by subject and activity
frequencybodyaccelerometerjerkstandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "fBodyAccJerk-std()-Y", grouped by subject and activity
frequencybodyaccelerometerjerkstandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "fBodyAccJerk-std()-Z", grouped by subject and activity
frequencybodygyroscopemeanx | Average of the means for the subject and activity for the original variable named "fBodyGyro-mean()-X", grouped by subject and activity
frequencybodygyroscopemeany | Average of the means for the subject and activity for the original variable named "fBodyGyro-mean()-Y", grouped by subject and activity
frequencybodygyroscopemeanz | Average of the means for the subject and activity for the original variable named "fBodyGyro-mean()-Z", grouped by subject and activity
frequencybodygyroscopestandarddeviationx | Average of the standard deviations for the subject and activity for the original variable named "fBodyGyro-std()-X", grouped by subject and activity
frequencybodygyroscopestandarddeviationy | Average of the standard deviations for the subject and activity for the original variable named "fBodyGyro-std()-Y", grouped by subject and activity
frequencybodygyroscopestandarddeviationz | Average of the standard deviations for the subject and activity for the original variable named "fBodyGyro-std()-Z", grouped by subject and activity
frequencybodyaccelerometermagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyAccMag-mean()", grouped by subject and activity
frequencybodyaccelerometermagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyAccMag-std()", grouped by subject and activity
frequencybodybodyaccelerometerjerkmagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyAccJerkMag-mean()", grouped by subject and activity
frequencybodybodyaccelerometerjerkmagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyAccJerkMag-std()", grouped by subject and activity
frequencybodybodygyroscopemagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyGyroMag-mean()", grouped by subject and activity
frequencybodybodygyroscopemagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyGyroMag-std()", grouped by subject and activity
frequencybodybodygyroscopejerkmagnitudemean | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyGyroJerkMag-mean()", grouped by subject and activity
frequencybodybodygyroscopejerkmagnitudestandarddeviation | Average of the Standard Deviation for the subject and activity for the original variable named "fBodyBodyGyroJerkMag-std()", grouped by subject and activity


  