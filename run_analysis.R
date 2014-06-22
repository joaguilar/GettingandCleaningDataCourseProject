#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.


create_new_name <- function(name){
  #This function processes a string with the name of the column and outputs a more descriptive name, based on the
  #recommendations from the "Editing Text Variables" lecture, on slide 16, which states:
  # Names of variables should be
  #  - All lower case when possible
  #  - Descriptive (Diagnosis vs Dx)
  #  - Not duplicated
  #  - Not have underscores or dots or white spaces
  #Based on the names of the columns in the original dataset, there are 6 pieces of information in the name, which are used
  #by this function for renaming:
  #1: Time or Frequency
  # If the columns starts with "t" or "f", it then gets renamed to "time" "frequency" as appropriate.
  #2: Body or Gravity
  #The second part of the name is either "Body" or "Gravity". These are mostly kept as it is already a full descriptive word
  #3: Acceleration of Gyroscopic
  #The next part of the name is the sensor from which the data comes from, in this case the "Gyroscope" or the "Accelerometer".
  #The full word is expanded from the abbreviations used in the original name.
  #4: Jerk, Magnitude or Jerk Magnitude
  #The Jerk signals are 
  #5: Mean or Std Dev
  #The original data set contains several additional functions, but after keeping only the mean and standard deviation it is
  #only necessary to rename these two functions from "mean" to "mean" and "std" to "standarddeviation"
  #6: X, Y or Z
  #Finally we need to keep the axis in which the signal was collected. This is kept as is, only lowecased: "X"->"X", "Y"->"Y", "Z"->"Z"
  #All underscores, dashes and parenthesis are removed from the name.
  #So for example the original column "tBodyAcc-mean()-X", will end up being named "timebodyaccelerometermeanx".
  newName<-name
  # Time or Frequency:
  newName<-gsub("^t","time",newName)  
  newName<-gsub("^f","frequency",newName)  
  # Body or Gravity:
  newName<-gsub("Body","body",newName)  
  newName<-gsub("Gravity","gravity",newName)  
  # Sensor, accelerometer or gyroscope:
  newName<-gsub("Gyro","gyroscope",newName)  
  newName<-gsub("Acc","accelerometer",newName)  
  # Jerk:
  newName<-gsub("Jerk","jerk",newName)  
  # Magnitude:
  newName<-gsub("Mag","magnitude",newName)  
  # Mean or standard deviation:
  newName<-gsub("-mean\\(\\)","mean",newName)  
  newName<-gsub("-std\\(\\)","standarddeviation",newName) 
  # X, Y or Z coordinates
  newName<-gsub("-X","x",newName)  
  newName<-gsub("-Y","y",newName)  
  newName<-gsub("-Z","z",newName)   
  newName
}


#First check if the dataset is present in the working directory:
if(!file.exists("UCI HAR Dataset")){
  stop("Unable to find UCI HAR Dataset directory")
}


#load the activity names from the "activity_labels.txt" file, and convert it to a character vector:
y_levels<-read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE)
y_levels_names<-as.character(y_levels[,2])

#Next, load the three files from the test directory:
test_subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
test_x_test<-read.table("UCI HAR Dataset/test/x_test.txt",header=FALSE)
test_y_test<-read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

#And the three files from the train directory:
train_subject_test<-read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
train_x_test<-read.table("UCI HAR Dataset/train/x_train.txt",header=FALSE)
train_y_test<-read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
  
#And combine them into three dataframes that will hold all the information from the 
# 2 sets (test and train) using rbind().
dataset_subject_test<-rbind(train_subject_test,test_subject_test)
dataset_x_test<-rbind(train_x_test,test_x_test)
dataset_y_test<-rbind(train_y_test,test_y_test)

#Next step is to convert the activities from the y_*.txt files into their proper names from the "activity_labels.txt" file
#we loaded earlier. This is from the step "Uses descriptive activity names to name the activities in the data set" in the 
#assignment:
dataset_y_test<-as.factor(dataset_y_test[,1])
levels(dataset_y_test)<-y_levels_names

#And a final dataset with all the rows from both files:
merged_dataset<-cbind(dataset_subject_test,dataset_y_test,dataset_x_test)

#Now that we have the dataset, let's name the columns. 
#First load the column names for the datasets loaded from x_*.txt
cn<-read.table("UCI HAR Dataset/features.txt")
cnv<-as.character(cn[,2])

#Assign the column names to the dataset. Note that since the first two columns come from the files subject_*.txt and y_*.txt,
#These two columns have to be named explicitly, in this case "Subject_ID" and "Activity_ID". The other column names come from 
#the "features.txt" file form the previous block of text.
names<-c("subjectid","activity",cnv)
colnames(merged_dataset)<-names

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#For this we filter out the columns based on the name, using the grep function. This will give me a vector
#that says which columns match the regular expression, which is looking for columns that have the strings
#mean() or std(). 
mean_std_cols <- c(1,2,grep("mean\\(\\)|std\\(\\)", names(merged_dataset)))
#Once we have the columns, we create a new dataset that only contains those columns. Note that we also include
#columns 1 and 2, that correspond to the "subject" and "activity" columns. These two would otherwise be filtered out.
merged_dataset_mean_std<-merged_dataset[,mean_std_cols]

#Appropriately labels the data set with descriptive variable names. 
#The next step is to rename the labels. At this point the names followa pattern similar to this:
# tGravityAcc-mean()-X
#This, however, does not follow R standard naming conventions. Based on the 
newNames<- vector(mode="character")
for(n in colnames(merged_dataset_mean_std)){
  newNames<-c(newNames,create_new_name(n))
}
colnames(merged_dataset_mean_std)<-newNames


#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_data<-aggregate(.~subjectid+activity,merged_dataset_mean_std,mean)

#And finally lets rename the columns to reflect the fact they are averages:
newNames<- vector(mode="character")
for(i in c(3:length(colnames(tidy_data)))){
  newName<-paste("average",colnames(tidy_data)[i],sep="")
  newNames<-c(newNames,newName)
}
colnames(tidy_data)<-c("subjectid","activity",newNames)

#And let's output the tidy data set to a file for uploading.
write.table(tidy_data,file="dataset.txt",row.names=FALSE)


