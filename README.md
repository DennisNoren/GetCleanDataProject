## Getting and Cleaning Data
### Coursera, June 2014, Course Project
### Dennis Noren

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each 
   variable for each activity and each subject.

### Data set is from UC Irvine Machine Learning Repository
### Human Activity Recognition Using Smartphones Data Set

- Date donated: 2012-12-10  
- Date downloaded to my compter: 2014-06-03  

### The computer used for processing  
- MacBook Pro  
- 8 GB RAM  
- 2.3 GHz Intel Core i7 processor  
- SSD storage  
- MacOS 10.8.5  
- R v3.1.0  
- RStudio 0.997.551  

### The data file was downloaded as a zip file from the following link:
[HAR Using Smartphone](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

To repeat this processing, do the following:
- Download from the above link
- Move zip file into desired folder
- Run an unzip utility to expand the folders/files, which will be like this:
- UCI HAR Dataset
  - activity_labels.txt {shows label key for activities
  - features_info.txt   {has feature information}
  - features.txt        {lists all 561 features}
  - test    {subfolder with data on 2947 rows}  
    -- Inertial Signals  {subfolder, not used for this analysis}  
    -- subject_test.txt  {subject IDs}  
    -- X_test.txt        {feature data, 561 fields}  
    -- y_test.txt        {activity code for each case}  
  - train    {subfolder with data on 7352 rows}  
    -- Inertial Signals  {subfolder, not used for this analysis}  
    -- subject_train.txt  {subject IDs}  
    -- X_train.txt        {feature data, 561 fields}  
    -- y_train.txt        {activity code for each case}  
- Copy the following files into the new /UCI HAR Dataset/ folder:
  - 1. README.md         {this file}
  - 2. CodeBook.md       {describes the variables and coding}
  - 3. run_analysis.R    {the single R processing script}
- In run_analysis.R file, find/replace "/R/getD" with your desired folder  
- In RStudio, or R Console, execute 'source ~/{desired folder}/UCI HAR Dataset/run_analysis.R'
- The output file is a comma-delimited text file:  ~/{desired folder}/UCI HAR Dataset/HAR_tidy_summ.txt

See CodeBook.md for detail on the data.

The feature data were in separate files from the subject and activity variables.
There are various ways these data can be merged and extracted.
I chose the following order:
- Read the subject, activity, and feature data into data frames
- Bind the subject and activity variables to the feature variables (makes it a coherent data set first)  
- Read feature names  
- Assign variable names to the training and test data sets  
- Bind the training and test sets together  
- Change the feature names to camelBackScheme(remove dashes and parentheses as they could cause problems/confusion in R)  
- (The basic scheme in the data source was OK, with enough description in the abbreviations, and some continuity is maintained with the source data codebook)  
- Select subset of features for means and std deviations  
- (Doing this late in the processing flow makes it easier for extended analysis, if needed at a later time)
- Convert 'activity' code from numeric to text
- Perform the aggregation by subject and activity
- Write the output file

### Notes:
- The processing time is small, on the order of 0.5 minutes  
- If future data set volumes are 1 to 2 orders of magnitude higher, it might be considered to change from data frames to data.table  
- The output data frame before aggregation is 'HAR_tidy'.  If desired the script could be modified to output that also.
- Some row count and column count checks are performed, which confirm some aspects
  of the source data codebook.  
- The feature data are intended to be normalized to a range of (-1, +1), so error checking is done for that.  
- A subset of 66 features, 33 related to means and 33 related to standard deviations was extracted by identifying substrings in the variable names.  
- (The source data codebook identified variable types that were estimated from the base signals)  
- (The two required feature types are mean and standard deviation.  Also listed were mean frequencies and angles, which includes some mean computations.  However, since the mean frequencies and angles were listed separately, it was judged that the intent was to only use the main mean and std features)  
- (In practice, I would have contacted the person/organization which requested the analysis for clarification, as variables for analysis is a central issue.  However, this is a course, and the general guidance we were given was to use our judgment from the project description)
  