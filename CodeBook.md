# Getting and Cleaning Data #

# Course Project - Code Book #

This code book indicates all the variables and summaries calculated, along any other relevant information.

## Original Dataset Information ##
### Files ###
The original dataset used for this analysis is from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "Human Activity Recognition Using Smartphones"). The file **"getdata-projectfiles-UCI HAR Dataset.zip"** was downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "getdata-projectfiles-UCI HAR Dataset.zip").

This zip file was expanded and uses as an input for the analysis. This zip file contains the following files that are relevant for the analysis:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


### Datasets ###

The original dataset contains several files


### Output dataset ###

#### Column descriptions ####

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


  