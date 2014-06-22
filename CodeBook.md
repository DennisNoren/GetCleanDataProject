## This document describes the data used and produced by run_analysis.R
### See README.md for description of processing steps

### Data set is from UC Irvine Machine Learning Repository
### Human Activity Recognition Using Smartphones Data Set

- Date donated: 2012-12-10  
- Date downloaded to my compter: 2014-06-03  

Notes on input data:
- 561 features
- Separated into training and test sets, with same structure
- Descriptive but awkward variable names are provided

Notes on output data:
- 66 features, those which are means and standard deviations
- The training and test sets were combined, with no distinction retained
- Feature variable names have been simplified for easier interpretation  
- Aggregated by the 30 subjects (people) and 6 activities
- All combinations are represented, so there are 180 rows in output
- This is a tidy set that is ready for exploratory and other analysis
- The script could be modified to also output the data before aggregation

The R processing script is:
{parent directory}/UCI HAR Dataset/run_analysis.R

The output data fields, in order, are:
- subject
- activity
- tBodyAccMeanX
- tBodyAccMeanY
- tBodyAccMeanZ
- tBodyAccStdX
- tBodyAccStdY
- tBodyAccStdZ
- tGravityAccMeanX
- tGravityAccMeanY
- tGravityAccMeanZ
- tGravityAccStdX
- tGravityAccStdY
- tGravityAccStdZ
- tBodyAccJerkMeanX
- tBodyAccJerkMeanY
- tBodyAccJerkMeanZ
- tBodyAccJerkStdX
- tBodyAccJerkStdY
- tBodyAccJerkStdZ
- tBodyGyroMeanX
- tBodyGyroMeanY
- tBodyGyroMeanZ
- tBodyGyroStdX
- tBodyGyroStdY
- tBodyGyroStdZ
- tBodyGyroJerkMeanX
- tBodyGyroJerkMeanY
- tBodyGyroJerkMeanZ
- tBodyGyroJerkStdX
- tBodyGyroJerkStdY
- tBodyGyroJerkStdZ
- tBodyAccMagMean
- tBodyAccMagStd
- tGravityAccMagMean
- tGravityAccMagStd
- tBodyAccJerkMagMean
- tBodyAccJerkMagStd
- tBodyGyroMagMean
- tBodyGyroMagStd
- tBodyGyroJerkMagMean
- tBodyGyroJerkMagStd
- fBodyAccMeanX
- fBodyAccMeanY
- fBodyAccMeanZ
- fBodyAccStdX
- fBodyAccStdY
- fBodyAccStdZ
- fBodyAccJerkMeanX
- fBodyAccJerkMeanY
- fBodyAccJerkMeanZ
- fBodyAccJerkStdX
- fBodyAccJerkStdY
- fBodyAccJerkStdZ
- fBodyGyroMeanX
- fBodyGyroMeanY
- fBodyGyroMeanZ
- fBodyGyroStdX
- fBodyGyroStdY
- fBodyGyroStdZ
- fBodyAccMagMean
- fBodyAccMagStd
- fBodyBodyAccJerkMagMean
- fBodyBodyAccJerkMagStd
- fBodyBodyGyroMagMean
- fBodyBodyGyroMagStd
- fBodyBodyGyroJerkMagMean
- fBodyBodyGyroJerkMagStd  

### The 'subject' field is a numeric identifier for the 30 individuals who had measurements taken

### The 'activity' variable is a text field for the type of activity
- These, along with original numeric codes are:
- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

### The 66 feature measurements are numeric averages for the feature measurements within subject/activity combinations
- The input measurements were normalized within a (-1, +1) range, so the output aggregates are also
