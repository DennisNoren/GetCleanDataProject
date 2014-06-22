# Getting and Cleaning Data
# Coursera, June 2014
# Course Project
# Dennis Noren
#
# 1- Merges the training and the test sets to create one data set.
# 2- Extracts only the measurements on the mean and standard deviation
#    for each measurement. 
# 3- Uses descriptive activity names to name the activities in the data set
# 4- Appropriately labels the data set with descriptive variable names. 
# 5- Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.
#
# Data set is from UC Irvine Machine Learning Repository
# Human Activity Recognition Using Smartphones Data Set
# http://archive.ics.uci.edu/ml/datasets/
#   Human+Activity+Recognition+Using+Smartphones
# Date donated: 2012-12-10
# Date downloaded to my compter: 2014-06-03
# Note: The above is a download link, so a download command was not required
# Only Base R is required in this script

sessionInfo()

# Read the training data set
setwd("~/Documents/R/getD/UCI HAR Dataset/train")
train_x <- read.table("X_train.txt", stringsAsFactors = FALSE)
train_subj <- read.table("subject_train.txt")
train_activity <- read.table("y_train.txt")

# Verify row counts for training set
print(ifelse(dim(train_x)[1] == dim(train_subj)[1]
       ,"Row count matches for training subjects"
       ,"Row count does not match for training subjects"))
print(ifelse(dim(train_x)[1] == dim(train_activity)[1]
       ,"Row count matches for training activities"
       ,"Row count does not match for training activities"))

# Read the test data set
setwd("~/Documents/R/getD/UCI HAR Dataset/test")
test_x <- read.table("X_test.txt", header=FALSE, stringsAsFactors = FALSE)
test_subj <- read.table("subject_test.txt")
test_activity <- read.table("y_test.txt")

# Verify row counts for test set
print(ifelse(dim(test_x)[1] == dim(test_subj)[1]
       ,"Row count matches for test subjects"
       ,"Row count does not match for test subjects"))
print(ifelse(dim(test_x)[1] == dim(test_activity)[1]
       ,"Row count matches for test activities"
       ,"Row count does not match for test activities"))

# Verify variable counts between training and test sets
print(ifelse(dim(train_x)[2] == dim(test_x)[2]
       ,"Feature count matches between training and test"
       ,"Feature count does not match between training and test"))

# combine subject and activity with feature variables
train_set <- cbind(train_subj, train_activity, train_x)
test_set <- cbind(test_subj, test_activity, test_x)

# Read the list of feature names and the activity codes
setwd("~/Documents/R/getD/UCI HAR Dataset")
features <- read.table("features.txt", header=FALSE, stringsAsFactors = FALSE)
activ_labels <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors = FALSE)

# Assemble variable names for data frames
vars <- c("subject", "activ", features[,2])
names(train_set) <- vars
names(test_set) <- vars

# Merge training and test sets by binding rows.
HAR_full <- rbind(train_set, test_set)

# from source data codebook, there are dashes and parentheses in feature names
#   use the dash before XYZ variables to uniquely replace with underscores
# First though, parentheses will help define correct subset of features
#   representing means and std devs
 indx_m <- grep("mean\\()",names(HAR_full))
 indx_s <- grep("std\\()",names(HAR_full))
 keepIndx <- sort(c(1:2, indx_m, indx_s))

#  remove dashes
 names(HAR_full) <- gsub("-", "", names(HAR_full))
#  remove parentheses from variable names, avoiding function call confusion
 names(HAR_full) <- gsub("\\(", "", names(HAR_full))
 names(HAR_full) <- gsub("\\)", "", names(HAR_full))
#  capitalize Mean and Std
 names(HAR_full) <- gsub("mean", "Mean", names(HAR_full))
 names(HAR_full) <- gsub("std", "Std", names(HAR_full))

# Perform range check to verify that all feature data is in (-1, +1) range
for (i in 3: ncol(HAR_full))  {
     if (min(HAR_full[,i]) < -1)
            print(paste0(names(HAR_full)[i], " has value below -1"))
     if (max(HAR_full[,i]) > 1)
            print(paste0(names(HAR_full)[i], " has value above 1"))
}

# apply index to extract subset of features
HAR_analysis <- HAR_full[,keepIndx]

# convert numeric activity code to text code
HAR_tidyp <- merge(HAR_analysis, activ_labels, by.x = "activ"
                      , by.y = "V1", all=TRUE)
HAR_tidy <- cbind(HAR_tidyp[, dim(HAR_tidyp)[2]]
                  , HAR_tidyp[, 2]
                  , HAR_tidyp[, 3:(dim(HAR_tidyp)[2]-1)])

names(HAR_tidy)[1] <- "activity"
names(HAR_tidy)[2] <- "subject"

# average values by activity and subject
HAR_tidy_summ <- aggregate(HAR_tidy[, 3:ncol(HAR_tidy)]
      , by = list(subject = HAR_tidy$subject, activity = HAR_tidy$activity)
      , FUN = mean)

# write tidy summary data to output text file
write.table(HAR_tidy_summ, file = "HAR_tidy_summ.txt", row.names = FALSE)