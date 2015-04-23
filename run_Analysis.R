run_Analysis<-function()
{
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1- Merges the training and the test sets:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# to create one data set.
# 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3- Uses descriptive activity names to name the activities in the data set
# 4- Appropriately labels the data set with descriptive variable names. 
# 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  
  require(data.table)
  
  #Path where all the files are as extracted from
  #https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  strFilesFolder<-"./UCI HAR Dataset/"
  
  ##READ GENERAL DATA  
    #Read Activity Master table (IdActivity,Activity) >> dfActivity
    dfActivity<-read.table(
      paste(strFilesFolder,"activity_labels.txt",sep="")
      ,na.strings=c("NA","N/A"),col.names=c("IdActivity","Activity"))
    
    #Read Features (col names for X data) >> dfFeatures
    dfFeatures<-read.table(
      paste(strFilesFolder,"features.txt",sep="")
      ,na.strings=c("NA","N/A")
      ,col.names=c("IdFeature","Feature"))
    
    #Get the index of Features that contain mean() or std()
    intMeanStdCols=dfFeatures[grep("(mean|std)\\(\\)", dfFeatures[, 2]),1]
    
  
  ##READ TRAIN DATA
    #Read X data >> dfTrain_X
    dfTrain_X<-read.table(
      paste(strFilesFolder,"train/X_train.txt",sep="")
      ,na.strings=c("NA","N/A"))
    
    #Read y data (activity by row of X) >> dfTrain_y
    dfTrain_y<-read.table(
      paste(strFilesFolder,"train/y_train.txt",sep="")
      ,na.strings=c("NA","N/A")
      ,col.names=c("IdActivity"))
    
    #Add column Activity (activity name) to dfTrain_y
    dfTrain_y$Activity<-dfActivity[dfTrain_y[,1],2]
    
    #Read subject data (subjectby row of X) >> dfTrain_subject
    dfTrain_subject<-read.table(
      paste(strFilesFolder,"train/subject_train.txt",sep="")
      ,na.strings=c("NA","N/A")
      ,col.names=c("IdSubject"))
  
    #Add column names to dfTrain_X (from dfFeatures)
    colnames(dfTrain_X)<-dfFeatures[,2]
    
    #Column bind data frames dtTrain_y,dfTrain_subject and
    #dfTrain_X. For the last, the columns that contain 'mean()' or 'std()'
    dfTrain<-cbind(dfTrain_y,dfTrain_subject,dfTrain_X[,intMeanStdCols])
  
  ##READ TEST DATA
    #The process is similar to the one seen in Train 
    dfTest_X<-read.table(
      paste(strFilesFolder,"test/X_test.txt",sep="")
      ,na.strings=c("NA","N/A"))
    
    dfTest_y<-read.table(
      paste(strFilesFolder,"test/y_test.txt",sep="")
      ,na.strings=c("NA","N/A")
      ,col.names=c("IdActivity"))
    
    dfTest_y$Activity<-dfActivity[dfTest_y[,1],2]
    
    dfTest_subject<-read.table(
      paste(strFilesFolder,"test/subject_test.txt",sep="")
      ,na.strings=c("NA","N/A")
      ,col.names=c("IdSubject"))
    
    colnames(dfTest_X)<-dfFeatures[,2]
    
    dfTest<-cbind(dfTest_y,dfTest_subject,dfTest_X[,intMeanStdCols])
    
  
  #Merge the Train and Test datasets in one datatable
  dtAll<-as.data.table(rbind(dfTrain,dfTest))
  
  #Calculate the average by Activity,Subject of all the columns
  avgAll<-dtAll[,lapply(.SD,mean),by="IdActivity,Activity,IdSubject"]
  
  #Generate file of averages by Activity,Subject
  write.table(avgAll,"activity_avgtydydata.txt",row.name=FALSE)
  
  
}






