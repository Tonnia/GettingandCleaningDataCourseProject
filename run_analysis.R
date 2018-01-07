
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "project.zip")
unzip("project.zip")

# 1. merges the training and the test sets to create one data set 

## load activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity_label")

## load column names
features <- read.table("UCI HAR Dataset/features.txt")

## read in train dataset  
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## read in test dataset
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## change column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity_id"
colnames(subject_train) <- "subject"
y2_train <- merge(y_train, activity_labels, by="activity_id")

colnames(x_test) <- features[,2]
colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject"
y2_test <- merge(y_test, activity_labels, by="activity_id")


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean.sd <- grepl("mean|sd", features[,2])
x_train <- x_train[,mean.sd]
x_test <- x_test[,mean.sd]
## merge datasets
train <- cbind(subject_train, y2_train, x_train)
test <- cbind(subject_test, y2_test, x_test)
merged <- rbind(train, test)
head(merged)
# 3. Uses descriptive activity names to name the activities in the data set
# done in step 1

# 4. Appropriately labels the data set with descriptive variable names.
# done in step 1 

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
id_labels <- c("subject","activity_id","activity_label")
merged_melt <- melt(merged, id.vars = id_labels,
                    measure.vars = setdiff(colnames(merged), id_labels))
tidy_data <- dcast(merged_melt, subject+activity_label~variable, mean)
write.table(tidy_data, file="tidy_data.txt")

unlink(tf, recursive = TRUE)