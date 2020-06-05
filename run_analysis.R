
library(dplyr)

#First of all, we have to unpakcage the data that
#is located on "./data/UCI HAR Dataset"

features <- read.table('./UCI HAR Dataset/features.txt')
activity <- read.table('./UCI HAR Dataset/activity_labels.txt',
                       col.names = c('code','activity'))


s_test <- read.table('./UCI HAR Dataset/test/subject_test.txt',
                     col.names = 'subject')
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
names(x_test)<-features[,2]
y_test <- read.table('./UCI HAR Dataset/test/Y_test.txt',
                     col.names = 'code')

s_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',
                      col.names = 'subject')
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
names(x_train)<-features[,2]
y_train <- read.table('./UCI HAR Dataset/train/Y_train.txt',
                     col.names = 'code')

#1. Merges the training and the test sets to create one data set.

complete_data <- cbind(rbind(s_train, s_test),
                       rbind(y_train, y_test),
                       rbind(x_train, x_test))




names(complete_data)
#2. Extracts only the measurements on the mean and standard 
#deviation for each measurement.

mean_std <- features[,2][grep("mean|std",features[,2])]
s_names <- c(as.character(mean_std),"subject","code")

tidy_data <-  complete_data%>%
              subset(select=c(as.character(mean_std),"subject","code"))

names(tidy_data)

# 3. Uses descriptive activity names to name the activities 
#in the data set

#Here tidy data code representes the adtivity code, and the corresponding 
#activity name is in table activity in the column activity
# to relationate the variables stored on tidy_data$code with it's labels

#activity[c(1,4,6,5,4,1,2,3,4,5,6),2]

tidy_data$code<-activity[tidy_data$code,2]

tidy_data
names(tidy_data)[2] = "activity"
#4. Appropriately labels the data set with descriptive variable names.

names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body",names(tidy_data))

names(tidy_data)[68]


#From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.



tidy_data2<-aggregate(. ~subject + activity, tidy_data, mean)
tidy_data2<-Data2[order(tidy_data2$subject,tidy_data2$activity),]


write.table(tidy_data2, "FinalData.txt", row.name=FALSE)

