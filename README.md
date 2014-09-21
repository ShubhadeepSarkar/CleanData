CleanData
=========

##Course Project for Getting and Cleaning Data

The data for the project has been taken from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Please also refer to the CodeBook in the git repository for understanding the variables in the output text  

##Step-by-step approach
The run_analysis.R code does the following:  
1. Merges the training and the test sets to create one data set  
2. Extracts only the measurements on the mean and standard deviation for each measurement  
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names  
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject  
  
####1. Merges the training and the test sets to create one data set  
Read test data and train data and merge them into 3 sets - data, labels, and subjects  
  
####2. Extracts only the measurements on the mean and standard deviation for each measurement  
Use the grepl() function to match the patterns of the strings of the names of the data frame. Only those names having "mean" and "std" are selected  
  
####3. Uses descriptive activity names to name the activities in the data set  
The activity labels are read from the text provided in the "UCI HAR Dataset" folder called activity_labels.txt. The cbind() function is then used to bind as a column the labels and subjects to the merged data  
  
####4. Appropriately labels the data set with descriptive variable names  
The paranthesis and the hyphens are then removed for descriptive variable names  
  
####5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject  
A tidier text is obtained by molting and casting the existing data setusing the subject and activity as IDs.
