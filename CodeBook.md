# Code Book 

## Initial Data

The script run_analysis.R uses the data.table package to process the URI HAR Dataset that has been downloaded previously from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project uses six different data, that includes subject_test.txt, subject_train.txt, x_train.txt, x_test.txt ,y_train_txt and y_tests.txt that are included in the URI HAR Dataset.

And also use the features.txt wich contains thecorrect variable name that corresponds either to a column of x_test.txt and a column of x_train.txt.

Further information about those data sets can be found in 

- features_info.txt
- README.txt 

where the last one gives a general description about the URI HAR Dataset.

## Project 


It performs 5 major steps including:

- Merges the training and the test sets to create one data set, in this step we use the data loaded in te variables feature, s_train, s_test, X_train, X_test, Y_train and Y_test. And bind it to obtain a complete data set stored in the variable complete_data.

- Extracts only the measurements on the mean and standard deviation for each measurement. For this step the features name is used to subset the data wich includes mean() or std().

- Uses descriptive activity names to name the activities in the data set, here we use the data labels stored in the data.table activity and asign it to the corresponding activity in the merge dataset.

- Appropriately labels the data set with descriptive variable names. We note that some labels are not complete, then using regular expressions we complete the task. 

- Finally, from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Here, aggregate function split the data into subsets and computes the summary statistic that in this case is the average of each variable.


At this point the data is stored as FinalData.txt
