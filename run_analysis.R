#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.

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
#the "features.txt" file
names<-c("subjectid","activity",cnv)
colnames(merged_dataset)<-names

#Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_cols <- c(1,2,grep("mean\\(\\)|std\\(\\)", names(merged_dataset)))
merged_dataset_mean_std<-merged_dataset[,mean_std_cols]
#Appropriately labels the data set with descriptive variable names. 

newNames<- vector(mode="character")
for(n in colnames(merged_dataset_mean_std)){
  newName<-n
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
  #gsub("-X","x",gsub("-mean\\(\\)","mean_",gsub("Acc","acceleration_",gsub("Body","body_",gsub("^t","time_",names_cols[3], fixed=FALSE)))))
  newNames<-c(newNames,newName)
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
write.table(tidy_data,file="dataset.txt",row.names=FALSE)