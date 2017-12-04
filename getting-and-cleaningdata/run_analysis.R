setwd("~/datasciencecoursera/getting-and-cleaningdata")
getwd()
dir()

require(knitr)
require(markdown)

## Read and Merge features training and test data sets
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- rbind(X_train, X_test)


## Read and Merge activities test and training data sets
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
activities <- rbind(y_train, y_test)

## Read and Merge subject's data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)


## Extracts only the measurements on the mean and standard deviation for each measurement
featurescol <- read.table("UCI HAR Dataset/features.txt")
mean.sd <- grep("-mean\\(\\)|-std\\(\\)", featurescol[, 2])
features.mean.sd <- features[, mean.sd]


## Assign descriptive activity names to name the activities in the data set
names(subject)<-c("subject")
names(activities)<- c("activity")
names(features.mean.sd)<- featurescol[mean.sd,2]
names(features.mean.sd) <- tolower(names(features.mean.sd)) 
names(features.mean.sd) <- gsub("\\(|\\)", "", names(features.mean.sd))

actlabels <- read.table('UCI HAR Dataset/activity_labels.txt')
actlabels[, 2] <- tolower(as.character(actlabels[, 2]))
actlabels[, 2] <- gsub("_", "", actlabels[, 2])
activities[,1] = factor(activities[,1],labels=actlabels[,2])

# Merge data set with descriptive activity names.
tidydata <- cbind(features.mean.sd,subject, activities)
names(tidydata)<-gsub("^t", "time", names(tidydata))
names(tidydata)<-gsub("^f", "frequency", names(tidydata))
str(tidydata)
write.table(tidydata, 'tidydata.txt', row.names = F)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
suppressWarnings(avg_tidydata <- aggregate(tidydata, by = list(subject=tidydata$subject, activity=tidydata$activity), FUN = mean))
#str(avg_tidydata)
avg_tidydata <- avg_tidydata[1:68]
write.table(avg_tidydata, 'tidydata_average.txt', row.names = F)