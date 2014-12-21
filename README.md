Coursera_GetData
================

The script works in the following steps:
* Reading the source data, assuming all the input files are in the "UCI HAR Dataset" folder in the working directory.
* Merging the training and the test sets of measurements, using **rbind**.
* Labelling the measurements data set with variable names from the "UCI HAR Dataset/features.txt" file.
* Extracting only the measurements on the mean and standard deviation for each measurement, using **grep** to select the relevant variables.
* Adding subjects' IDs and activity names to the measurements data set. **Warning**: to avoid incorrect row ordering when merging activity IDs and names, I first use **cbind** to add subjects' and activities' IDs to the measurements data set, and only then merge it with the activity names from the "UCI HAR Dataset/activity_labels.txt" file.
* Creating a tidy data set with the average of each measurement for each activity and each subject, using **aggregate**.
* Writing the tidy data set with the averages, to the "**S_A_means.txt**" file in the working directory.

