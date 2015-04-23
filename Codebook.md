---
title: "Codebook"
output: html_document
---
This codebook describes the variables, the data, and any transformations or work performed on dataset [Human Activity Recognition Using Smartphones Data Set Coursera](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in order to get a tidy data set where we calculate the mean of all the variables that contain mean() or std() in its name from the union of the original Train and Test datasets by Subject and Activity

###Original dataset
All the data used can be obtained from [Human Activity Recognition Using Smartphones Data Set Coursera](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
A full description can be obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

###Original dataset info
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

###Transformation and Work performed on original dataset
Following the guide given by coursera I created a one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The full 5 steps are covered on the run_analysis.R file, that performs the following:  

1. Read activity_labels.txt into dfActivity
2. Read features.txt into dfFeatures
3. Get an array that contains the index of features from dfFeatures that contain in its name the word 'mean()' or 'std()'
4. Read '.train/X_train.txt' into dfTrain_X
5. Read '.train/y_train.txt' into dfTrain_y
6. Add a column describing the activity into dfTrain_y using the dfActivity dictionary
7. Read 'train/subject_train.txt' into dfTrain_subject
8. Add column names to dfTrain_X from dfFeatures
9. Create a new dataframe dfTrain that column binds dfTrain_y, dfTrain_subject and the columns of dfTrain_X according to the indexes array of step 3
10. Perform steps 4 to 9 on the test files to create dfTest
11. Row binds dfTrain and df into dtAll(data.table)
12. Group dtAll by Activity and Subject, calculating the mean for this grouping for the rest of variables
13. Generate a txt file named activity_avgtydydata.txt with the result of step 12



