library('reshape2')

# Find data in local repository if there, if not, download and unzip
if (!file.exists("UCI HAR Dataset")) { 
  zipped_file <-  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 'UCI HAR Dataset.zip', method="curl")
  unzip('UCI HAR Dataset.zip') 
}

# load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
colnames(activityLabels) <- c("id", "activity")
# load feature labels
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the meand and standard deviation of each variable
wantedFeatures <- grep(".*mean.*|.*std.*", features[,2])
wantedFeatureNames <- features[wantedFeatures,2]
wantedFeatureNames <- gsub('-mean', 'Mean', wantedFeatureNames)
wantedFeatureNames <- gsub('-std', 'Std', wantedFeatureNames)
wantedFeatureNames <- gsub('BodyBody', 'Body', wantedFeatureNames)
wantedFeatureNames <- gsub('[()-]', '', wantedFeatureNames)

# load training data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[wantedFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# load test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[wantedFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the training and the test sets to create one data set
mergedData <- rbind(train, test)
# add proper column names
colnames(mergedData) <- c("subject", "activity", wantedFeatureNames)
head(mergedData)
# replace activity id with activity label
mergedData$activity <- activityLabels$activity[match(mergedData$activity, activityLabels$id)]


# turn activities & subjects into factors
mergedData$activity <- as.factor(mergedData$activity)
mergedData$subject <- as.factor(mergedData$subject)

# calculate mean of all variables for each subject and activity
mergedData.melt <- melt(mergedData, id = c("subject", "activity"))
tidyData <- dcast(mergedData.melt, subject + activity ~ variable, mean)

# save tidy data to txt and csv files
write.csv(tidyData, "tidy_data.csv", row.names=FALSE)
write.table(tidyData, "tidy_data.txt", row.names=FALSE)