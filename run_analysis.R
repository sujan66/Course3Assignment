library(dplyr)

#utility functions
source(".\\util.R")

#location of files to be read
features <- ".\\UCI HAR Dataset\\features.txt"  #features
act_labels <- ".\\UCI HAR Dataset\\activity_labels.txt"  #activity labels

subject_test <- ".\\UCI HAR Dataset\\test\\subject_test.txt"  #test subject IDs
X_test <- ".\\UCI HAR Dataset\\test\\X_test.txt" #test signal readings
Y_test <- ".\\UCI HAR Dataset\\test\\Y_test.txt" #test activity IDs

subject_train <- ".\\UCI HAR Dataset\\train\\subject_train.txt"  #train subject IDs
X_train <- ".\\UCI HAR Dataset\\train\\X_train.txt" #train signal readings
Y_train <- ".\\UCI HAR Dataset\\train\\Y_train.txt" #train activity IDs

#merge the test and train datasets
X_dataset <- merge_dataset(X_test, X_train)
Y_dataset <- merge_dataset(Y_test, Y_train)
subject_dataset <- merge_dataset(subject_test, subject_train)

#extract the names of activities and variable names i.e. features
var_names <- extract_dataset(features)
act_labs <- extract_dataset(act_labels)

#obtain the indices of all var_names that contain "mean()" or "std()" 
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", var_names)
tidy_data1 <- select(X_dataset, all_of(mean_std_indices))

#renaming variables of Y_dataset and subject_dataset
Y_dataset <- rename(Y_dataset, Activity = V1)
subject_dataset <- rename(subject_dataset, subjectId = V1)
  
#encoding activity name in Y_dataset using act_labs
Y_dataset <- mutate(Y_dataset, Activity = factor(Activity, labels = act_labs))  

#renaming variables of tidy_data1 with var_names of appropriate indices
names(tidy_data1) <- var_names[mean_std_indices]

#combining subject_dataset, Y_dataset and tidy_data1 and arranging them in that order
tidy_data2 <- cbind(subject_dataset, Y_dataset, tidy_data1)
tidy_data2 <- arrange(tidy_data2, subjectId, Activity)

#grouping tidy_data2 by subjectId and Activity and summarizing all variables
#by function mean
tidy_data3 <- tidy_data2 %>% group_by(subjectId, Activity) %>% summarize_all(mean)