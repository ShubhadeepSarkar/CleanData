## Task - You should create one R script called run_analysis.R that does the following. 
## Load required libraries
library(plyr)
library(reshape2)

##---------------------------------------------------------------------------------------
## 1. Merges the training and the test sets to create one data set

## Assumption - unzipped UCI HAR Dataset folder is in the working directory
## Read test data
xtest <- read.table("./UCI HAR Dataset/test/x_test.txt") #test data
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt") #test lables
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")   # test subjects

## Read train data
xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")       # train data
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")       # train labels
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") # train subjects

# merge the test and train data, row-wise
allActivity <- rbind(xtest,xtrain)

# merge the test and train lables, row-wise
allLabel <- rbind(ytest,ytrain)

# merge the test and train subjects, row-wise
allSubjects <- rbind(subtest,subtrain) 

##---------------------------------------------------------------------------------------
##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## Read the features
features <- read.table("./UCI HAR Dataset/features.txt")

## use the grepl() to identify values that correspond to the means and standard deviation measures
mean_std_features  <- grepl("(-std\\(\\)|-mean\\(\\))",features$V2)

## remove columns that are not mean or std
filteredActivity <- allActivity[,which(mean_std_features==TRUE)]

##---------------------------------------------------------------------------------------
##3. Uses descriptive activity names to name the activities in the data set
# Read the set of activity labels from the txt file
activityLabels  <- read.table("./UCI HAR Dataset/activity_labels.txt")

# transform the allLabel from integer codes to factors
activity <- as.factor(allLabel$V1)

# transform the label factors into a vector of human readable activity descriptions
levels(activity) <- activityLabels$V2

# transform the subject codes to factors, as they will be used as factors later on.
subject <- as.factor(allSubjects$V1)

# bind as a column the allLabels vector to the dataset
filteredActivity <- cbind(subject,activity,filteredActivity)

##---------------------------------------------------------------------------------------
##4. Appropriately labels the data set with descriptive variable names. 
## capture the features that are required 
filteredfeatures <- (cbind(features,mean_std_features)[mean_std_features==TRUE,])$V2

## clean the paranthesis and he hyphens from the features
cleanfeatures <- function(features) {
        tolower(gsub("(\\(|\\)|\\-)","",features))
}
filteredfeatures <- sapply(filteredfeatures,cleanfeatures)

## add the clean filtered features as names of the fileteredActivity data set
names(filteredActivity)[3:ncol(filteredActivity)] <- filteredfeatures

## write the final dataset to a CSV file, and as a text file
write.table(filteredActivity,file="TidyData.txt", sep="\t")

##---------------------------------------------------------------------------------------
##5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Assign IDs using the melt function
reshapedActivity <- melt(filteredActivity,id.vars=c("subject","activity"))
tidierData <- dcast(reshapedActivity,subject + activity ~ variable,mean)
write.table(tidierData, "TidierData.txt", sep="\t", row.name=FALSE)