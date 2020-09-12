---
title: "Codebook.md"
output: html_document
---


Contains information on variables of Tidy dataset, intermediary data and methods used in the scripts
for cleaning up the data.

original dataset : [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


## Tidy_Data.txt

dim : 180 X 68

- subjectId : ID of the individual among the 30 volunteers. [Integer] [column 1]
- Activity : activities performed for each readings. Grouped by subjectId. [Factor] [column 2]
- The remaining variables are the mean and standard deviation of the triaxial accelerometer and
    gyroscope readings of both the time and frequency domain variables, their corresponding
    magnitudes of the three-dimensional signals and excluding the mean frequency and angle
    variables. The variables are grouped by Activity variable. [Character] [column 3 : 68]
  - tBodyAcc-mean()-X           
  - tBodyAcc-mean()-Y
  - tBodyAcc-mean()-Z
  - tBodyAcc-std()-X
  - tBodyAcc-std()-Y
  - tBodyAcc-std()-Z
  - tGravityAcc-mean()-X
  - tGravityAcc-mean()-Y
  - tGravityAcc-mean()-Z
  - tGravityAcc-std()-X
  - tGravityAcc-std()-Y
  - tGravityAcc-std()-Z
  - tBodyAccJerk-mean()-X
  - tBodyAccJerk-mean()-Y
  - tBodyAccJerk-mean()-Z
  - tBodyAccJerk-std()-X
  - tBodyAccJerk-std()-Y
  - tBodyAccJerk-std()-Z
  - tBodyGyro-mean()-X
  - tBodyGyro-mean()-Y
  - tBodyGyro-mean()-Z         
  - tBodyGyro-std()-X
  - tBodyGyro-std()-Y
  - tBodyGyro-std()-Z
  - tBodyGyroJerk-mean()-X
  - tBodyGyroJerk-mean()-Y
  - tBodyGyroJerk-mean()-Z
  - tBodyGyroJerk-std()-X
  - tBodyGyroJerk-std()-Y
  - tBodyGyroJerk-std()-Z
  - tBodyAccMag-mean()
  - tBodyAccMag-std()
  - tGravityAccMag-mean()
  - tGravityAccMag-std()        
  - tBodyAccJerkMag-mean()
  - tBodyAccJerkMag-std()      
  - tBodyGyroMag-mean()
  - tBodyGyroMag-std()
  - tBodyGyroJerkMag-mean()
  - tBodyGyroJerkMag-std()
  - fBodyAcc-mean()-X
  - fBodyAcc-mean()-Y
  - fBodyAcc-mean()-Z
  - fBodyAcc-std()-X
  - fBodyAcc-std()-Y
  - fBodyAcc-std()-Z
  - fBodyAccJerk-mean()-X
  - fBodyAccJerk-mean()-Y
  - fBodyAccJerk-mean()-Z
  - fBodyAccJerk-std()-X
  - fBodyAccJerk-std()-Y
  - fBodyAccJerk-std()-Z
  - fBodyGyro-mean()-X
  - fBodyGyro-mean()-Y
  - fBodyGyro-mean()-Z
  - fBodyGyro-std()-X
  - fBodyGyro-std()-Y          
  - fBodyGyro-std()-Z
  - fBodyAccMag-mean()
  - fBodyAccMag-std()
  - fBodyBodyAccJerkMag-mean()
  - fBodyBodyAccJerkMag-std()
  - fBodyBodyGyroMag-mean()
  - fBodyBodyGyroMag-std()
  - fBodyBodyGyroJerkMag-mean()
  - fBodyBodyGyroJerkMag-std()
  

## run_analysis.R

# data / objects

- The names of the text files along with the directory from the working directory. [Character] 
  - features : The features.txt file
  - act_labels : The activity_labels.txt file
  - subject_test : The subject_test.txt file
  - X_test : The X_test file
  - Y_test : The Y_test file
  - subject_train : The subject_train.txt file
  - X_train : The X_train.txt file
  - Y_train : The Y_train.text file
  
- X_dataset : Data table containing the test and train readings [data.frame] [dim : 10299 X 561]
- Y_dataset : Data table containing the test and train activity label IDs [data.frame] [dim : 10299 X 1]
- subject_dataset : Data table conatining the test and train subject IDs [data.frame] [dim : 10299 X 1]

- var_names : vector containing the features or variables of readings [Character] [len : 561]
- act_labs : vector containing the activities performed [Character] [len : 6]

- mean_std_indices : vector containing the indices of the variable names in var_name with mean() and
                     std() readings [Integer] [len : 66]

- tidy_data1 : Subset of the X_dataset containing the variables corresponding to the
               mean_std_indices [data.frame] [dim : 10299 X 66]
- tidy_data2 : data table containing subject_dataset, Y_dataset and tidy_data values [data.frame]
               [dim : 10299 X 68]
- tidy_data3 : data table containing the average values of the readings grouped by subjectId and
               Activity [dim : 180 X 68]


## util.R

- The script reads the data the from text files and appends test and train datasets.

  - merge_data(x, y) : This function takes two character strings i.e. the file name/location as 
                       arguments and returns a data frame of the data read from the files and 
                       appends both the data into a single set. [Function]
                       
  - extract_dataset(x) : This function takes one character string i.e the file name/location as 
                         argument and returns a vector of the data in the second column of dataset
                         read from the file. [Function]
                         

## Transformations

- The datasets from both train and test datasets are read and appended using the util function
  merge_data. The library dplyr is used for formatting the data frame.

- The variable names and activities are read from features and activity_labels dataset using the
  the util function extract_dataset. The second column in the data i.e. the names are returned
  as vectors.
  
- The indices of variable names in var_names that contain mean() and std() are obtained using grep
  function. Note that meanFreq() and angle(...mean) variables are not used for extraction.
  
- tidy_data1 is obtained by subsetting the X_dataset that contain mean() and std() as variables
  using select function and mean_std_indices vector.
  
- The variables in Y_dataset and subject_dataset vectors are renamed to Activity and subjectId 
  respectively.

- The values of the Activity variable in Y_dataset are changed to their corresponding activity in 
  act_labs using mutate and factor methods.
  
- The variable names of tidy_data1 are changed to reflect their corresponding names in var_names.

- tidy_data2 is obtained by merging subject_dataset, Y_dataset and tidy_data1 in that order using 
  cbind function (to preserve the order of the rows) and is arranged according to the values of 
  subjectId and activity using arrange method.
  
- tidy_data3 is obtained by grouping tidy_data2 by subjectId and activity using group_by function
  and averaging the reading values by the groups created using summarize method.