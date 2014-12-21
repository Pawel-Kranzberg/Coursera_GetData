## 0. Reading the raw data

# setwd("d:/PK/R/Coursera-GetData/course_project")
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
act <- read.table("UCI HAR Dataset/activity_labels.txt")
lev <- as.character(act[,2])
act[,2] <- factor(act[,1], labels = lev)

## 1. Merging the training and the test sets 
## (continued in step 4 below)

merged1 <- rbind(train, test)

## 2. Labelling the data set with descriptive variable names

names(merged1) <- features$V2

## 3. Extracting only the measurements on the mean
## and standard deviation for each measurement

# mean_std_i <- setdiff(setdiff(grep("-mean|-std", names(merged1)), grep("-meanF", names(merged1))), grep("^angle", names(merged1)))
mean_std_i <- setdiff(grep("-mean|-std", names(merged1)), 
                      grep("-meanF", names(merged1)))
merged2 <- merged1[mean_std_i]

## 4. Use descriptive activity names to name the activities in the data set

activities <- rbind(train_act, test_act)
subjects <- rbind(train_subject, test_subject)
merged2 <- cbind(activities, subjects, merged2)
names(merged2)[1:2] <- c("activity", "subject")
merged2 <- merge(merged2, act, by = 1)
merged2$activity <- merged2$V2
merged2$V2 <- NULL

# colnames(activities) <- c("ID", "activity")
# merged2 <- merged2[c(2, 69, 3 : 68)]
# names(merged2)[1] <- "activity"
# merged2$activity <- activities$V2

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

cut <- paste(merged2$subject, as.numeric(merged2$activity), sep = "-")
merged3 <- cbind(cut, merged2[-1:-2])
merged4 <- aggregate(. ~ cut, merged3, mean)
cut_ids <- unique(cbind(cut, merged2[c(2, 1)]))
S_A_means <- merge(cut_ids, merged4, by = "cut")
S_A_means$cut <- NULL
S_A_means <- S_A_means[order(S_A_means[1]),]

## 6. Outputting the tidy data set as a .txt file

write.table(S_A_means, "S_A_means.txt", row.name = FALSE)

