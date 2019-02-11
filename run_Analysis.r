#dplyr provides a flexible grammar of data manipulation. It's the next iteration of plyr, focused on tools for working with data frames (hence the d in the name).
library(dplyr)

# Generic variables 

dataFileName <- "getdata_projectfiles_UCI HAR Dataset.zip"
dataFileDir <- "UCI HAR Dataset"
dataFilePath <- paste0(getwd(),"/", dataFileName)



# STEP 1 - Get data
# Chcek if data exists in working directory.
if (!file.exists(dataFilePath)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, dataFilePath, method="curl")
}  


# STEP 1.1 - Unzip previously obtained data
if (file.exists(dataFilePath) & !file.exists(dataFileDir)) { 
  unzip(dataFilePath) 
}


# read features data
features <- read.table(file.path(dataFileDir, "features.txt"), col.names = c("id","activity"))

# read training data
trainingSubjects <- read.table(file.path(dataFileDir, "train", "subject_train.txt",fsep = .Platform$file.sep),col.names = "subject")
trainingValues <- read.table(file.path(dataFileDir, "train", "X_train.txt",fsep = .Platform$file.sep), col.names = features$activity)
trainingActivity <- read.table(file.path(dataFileDir, "train", "y_train.txt",fsep = .Platform$file.sep),col.names = "code")

# read test data
testSubjects <- read.table(file.path(dataFileDir, "test", "subject_test.txt",fsep = .Platform$file.sep),col.names = "subject")
testValues <- read.table(file.path(dataFileDir, "test", "X_test.txt",fsep = .Platform$file.sep), col.names = features$activity)
testActivity <- read.table(file.path(dataFileDir, "test", "y_test.txt",fsep = .Platform$file.sep), col.names = "code")

# read activities. Has two columns 
activities <- read.table(file.path(dataFileDir, "activity_labels.txt",fsep = .Platform$file.sep), col.names = c("activityCode", "activityName"))


humanActivity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)


tidyData <- humanActivity %>% select(subject, code, contains("mean"), contains("std"))


tidyData$code <- activities[tidyData$code, 2]

names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "timeDomain", names(tidyData))
names(tidyData)<-gsub("^f", "frequencyDomain", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "StandardDeviation", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))



finalData <- tidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(finalData, "tidy_data_set.txt", row.name=FALSE)

