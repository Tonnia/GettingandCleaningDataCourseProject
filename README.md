# GettingandCleaningDataCourseProject

## Purpose

The script performing the analysis is save in run_analysis.R. It does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps

1. Download the dataset from the given link. 
2. Load the activity and feature data
3. Load both train and test datasets. Extract only the measurements on the mean and standard deviation for each measurement, merge them into one dataset called "merged".
4. Use `subject`, `activity_id` and `activity_label` as the id variables to melt the dataset.
5. Create a tidy dataset called "tidy_data" that consists of the mean value of the features for each subject and activity. 
