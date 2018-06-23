## The below R script will
# Download UCI HAR Dataset from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Downloading the data set
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")
unzip("dataset.zip")
path = file.path(".","UCI HAR Dataset")
files = list.files(path, recursive = T)

## Reading the datasets

# Read the features data
features <- read.table(file.path(path, "features.txt"),header = FALSE)

# Read the activity labels data
activityLabels <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
colnames(activityLabels) <- c("activityID","activityType")

#Reading the training data set
xtrain <- read.table(file.path(path, "train/X_train.txt"), header = FALSE)
ytrain <- read.table(file.path(path, "train/y_train.txt"), header = FALSE)
trainSubjects <- read.table(file.path(path, "train/subject_train.txt"), header = FALSE)
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityID"
colnames(trainSubjects) <- "subjectID"


# Reading the test data set
xtest <- read.table(file.path(path, "test/X_test.txt"), header = FALSE)
ytest <- read.table(file.path(path, "test/y_test.txt"), header = FALSE)
testSubjects <- read.table(file.path(path, "test/subject_test.txt"), header = FALSE)
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityID"
colnames(testSubjects) <- "subjectID"

## Create a complete train and test set
trainSet <- cbind(xtrain, ytrain, trainSubjects)
testSet <- cbind(xtest, ytest, testSubjects)


## Combine Training Data Set and Test Data Set into one Merged Data Set
mergeData <- rbind(trainSet, testSet)

##get a subset of all the mean and standards and the correspondongin activityID and subjectID
meanStd <- (grepl("activityId" , features[,2]) | grepl("subjectId" , features[,2]) | grepl("mean.." , features[,2]) | grepl("std.." , features[,2]))
# Now subset the dataset with desired columns
mergeData <- mergeData[,meanStd]

##Using descriptive activity names to name the activities in the data set
sortedData <- merge(mergeData, activityLabels, by='activityID', all.x=TRUE)

##Now tidying the dataset

tidyData <- aggregate(.~ subjectID + activityID, sortedData, mean)
tidyData <- tidyData[order(tidyData$subjectID, tidyData$activityID),]

## Write the tidy dataset to a file
write.table(tidyData, "tidyData.txt", row.name=FALSE)