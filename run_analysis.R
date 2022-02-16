#************************************************************************
# Data Preparation: Download, Unzip and create initial Data Frames
#************************************************************************

# Load the required package 'dplyr'
library(dplyr)

# Assign Coursera_DS3_Final.zip as 'projdataset' filename
projdataset <- "Coursera_DS3_Final.zip"

# Download the file if the project filename does not exist
if (!file.exists(projdataset)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, projdataset, method="curl")
}  

# Once the zip project filename is downloaded, proceed with unzipping the file.
if (!file.exists("UCI HAR Dataset")) {
  unzip(projdataset) 
}

# Read features.txt in a table format and creates the 'features' data frame
# with n and functions 'headers'
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

# Read activity_labels.txt in a table format and creates the 'activity_labels' data frame
# with code and activity_name 'headers'
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity_name"))

# Read subject_test.txt in a table format and creates the 'subject_test' data frame
# with subject 'header'
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Read X_test.txt in a table format and creates the 'test_set' data frame
test_set <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

# Read y_test.txt in a table format and creates the 'test_lbl' data frame
# with code 'header'
test_lbl <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Read subject_train.txt in a table format and creates the 'subject_train' data frame
# with subject 'header'
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Read X_train.txt in a table format and creates the 'train_set' data frame
train_set <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

# Read y_train.txt in a table format and creates the 'train_lbl' data frame
# with code 'header'
train_lbl <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#************************************************************************
# Step 1: Merges the training and the test sets to create one data set
#************************************************************************

#Combine test and train (set and labels) data frames by rows
df_train_test_set <- rbind(train_set, test_set)
df_train_test_lbl <- rbind(train_lbl, test_lbl)
df_Subject <- rbind(subject_train, subject_test)

#Combine test, train, subject data frames by columns
df_Merged <- cbind(df_Subject, df_train_test_lbl, df_train_test_set)

#************************************************************************
# Step 2: Extracts only the measurements on the mean and standard 
#         deviation for each measurement.
#************************************************************************
df_Tidy <- df_Merged %>% select(subject, code, contains("mean"), contains("std"))

#************************************************************************
# Step 3: Uses descriptive activity names to name the activities
#         in the data set.
#************************************************************************
df_Tidy$code <- activity_labels[df_Tidy$code, 2]

#************************************************************************
# Step 4: Appropriately labels the data set with descriptive 
#         variable names.
#************************************************************************
names(df_Tidy)[2] = "activity_name"
names(df_Tidy)<-gsub("Acc", "Accelerometer", names(df_Tidy))
names(df_Tidy)<-gsub("Gyro", "Gyroscope", names(df_Tidy))
names(df_Tidy)<-gsub("BodyBody", "Body", names(df_Tidy))
names(df_Tidy)<-gsub("Mag", "Magnitude", names(df_Tidy))
names(df_Tidy)<-gsub("^t", "Time", names(df_Tidy))
names(df_Tidy)<-gsub("^f", "Frequency", names(df_Tidy))
names(df_Tidy)<-gsub("tBody", "TimeBody", names(df_Tidy))
names(df_Tidy)<-gsub("-mean()", "Mean", names(df_Tidy), ignore.case = TRUE)
names(df_Tidy)<-gsub("-std()", "STD", names(df_Tidy), ignore.case = TRUE)
names(df_Tidy)<-gsub("-freq()", "Frequency", names(df_Tidy), ignore.case = TRUE)
names(df_Tidy)<-gsub("angle", "Angle", names(df_Tidy))
names(df_Tidy)<-gsub("gravity", "Gravity", names(df_Tidy))

#************************************************************************
# Step 5: From the data set in step 4, creates a second, independent
#         tidy data set with the average of each variable for each
#         activity and each subject.
#************************************************************************

group_df_Tidy<-group_by(df_Tidy,subject,activity_name)
FinalDS<-summarise_all(group_df_Tidy,mean)

# Exporting the Final data set into a txt file "FinalDataSet.txt"
write.table(FinalDS, "FinalDataSet.txt", row.name=FALSE)

