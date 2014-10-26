## Reading the raw data

# setwd("d:/PK/R/Coursera-GetData/course_project")
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("UCI HAR Dataset/train/y_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
act <- read.table("UCI HAR Dataset/activity_labels.txt")
lev <- as.character(act[,2])
act[,2] <- factor(act[,1], labels = lev)

## Merging the training and the test sets 

merged1 <- rbind(train, test)

## Labelling the data set with descriptive variable names

names(merged1) <- features$V2

## Extracting only the measurements on the mean
## and standard deviation for each measurement

# mean_std_i <- setdiff(setdiff(grep("-mean|-std", names(merged1)), grep("-meanF", names(merged1))), grep("^angle", names(merged1)))
mean_std_i <- setdiff(grep("-mean|-std", names(merged1)), 
                      grep("-meanF", names(merged1)))
merged2 <- merged1[mean_std_i]

## Use descriptive activity names to name the activities in the data set

activities <- rbind(train_act, test_act)
activities <- merge(activities, act, by = "V1", sort = FALSE)
# colnames(activities) <- c("ID", "activity")
# merged2 <- cbind(activities[,2], merged2)
merged2$activity <- activities$V2
merged2 <- merged2[,c(67, 1 : 66)]

## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
