==================================================================
Getting And Cleaning Data Coursera Assignment - Week 4
==================================================================

The goal this assignment is to prepare tidy data that can be used for later analysis. In this assignment a tidy data set has been uploaded and a link to a Github repository with R script for performing the analysis, and a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md.

The data used for this assignment:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files included are:

- 'README.txt'

- 'run_analysis.R': The R script containing all the analysis code.

- 'CodeBook.md': Code Book containing all the variables, the data and work that was performed

The initial data set has training and test data. The first step was to merge training and test data for features, activities and subject dataframes respectively. The description of these files used to create dataframes as follows:
- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

After that, only the measurements on the mean and standard deviation for each measurement were extracted from the data set. The descriptive activity names were assigned to name the activities in the data sets for features, activities and subject. The data set with descriptive activity names were merged. Those variables were further summarized by taking their mean for each subject/activity pair. 

The final data set can be found in the tidydata.txt file. A detailed description of the variables can be found in CodeBook.md.
