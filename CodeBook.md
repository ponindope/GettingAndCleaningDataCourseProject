run_analysis.R script performs the following:

Data Preparation: Download, Unzip and create initial Data Frames
   a. Load the required package 'dplyr'
   b. Assign Coursera_DS3_Final.zip as 'projdataset' filename
   c. Download the file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" if the project filename does not exist
   d. Once the zip project filename is downloaded, proceed with unzipping the file (unzip(projdataset))
   e. Read txt source files in a table format and creates the corresponding data frames with 'headers'

Step 1: Merges the training and the test sets to create one data set
   a.Combine test and train (set and labels) data frames by rows
   b.Combine test, train, subject data frames by columns

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Step 3: Uses descriptive activity names to name the activities in the data set

Step 4: Appropriately labels the data set with descriptive variable names
  - Replace "Acc" with "Accelerometer"
  - Replace "Gyro" with "Gyroscope"
  - Replace "BodyBody" with "Body"
  - Replace "Mag" with "Magnitude"
  - Replace "^t" with "Time"
  - Replace "^f" with "Frequency"
  - Replace "tBody" with "TimeBody"
  - Replace "-mean()" with "Mean"
  - Replace "-std()" with "STD"
  - Replace "-freq()" with "Frequency"
  - Replace "angle" with "Angle"
  - Replace "gravity" with "Gravity"

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final Process: Export the Final data set into a txt file "FinalDataSet.txt"