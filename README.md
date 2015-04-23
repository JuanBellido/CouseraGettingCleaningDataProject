Getting and Cleaning Data Coursera Course Project README
========================================================
This repository contains my solution to the Coursera 'Getting and Cleaning Data' Course Project

###Course Project Instructions
Submit:  
1) a tidy data set as described below
2) a link to a Github repository with your script for performing the analysis
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts

Create one R script called run_analysis.R that does the following.  

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###How to run this
- You will need R and 'data.table' package
- Download the zip file [Human Activity Recognition Using Smartphones Data Set Coursera](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract in one folder of your computer
- Save run_analysis.R from this repo in the folder of the previous step
- Set your working directory in R to the folder
- Then load the run_analysis.R in R -sorce("run_analysis.R")- and execute -run_analysis.R()-

###Additional Info
- Refer to the Codebook.md
