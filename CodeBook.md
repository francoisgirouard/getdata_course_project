CodeBook
========

Variables
---------

Two variables will be left over after the execution of the script:

- firstTidyDataSet: a data frame containing the merged and subsetted data described in the course project.
- secondTidyDataSet: a data frame containing the summarized (mean) data from the first data set, grouped by subject and activity.

While running, the script uses a variety of variables that are cleaned up before the end of the script. Most are constants placed at the beginning of the script for easy tweaking. Other than those, the most notable are X (containing the merged data of the X_test.txt and X_train.txt files), Activity and Subject.

Data
----

The data consists of the content of files from the "UCI HAR Dataset.zip", a collection of motion data captured by smartphone described at the following URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Transformations
---------------

The data is first loaded and merged from the different files:
- X_train.txt and X_test.txt are row-bound into the X data frame.
- feature.txt, after formatting, provides the column names for the X data frame.
- subject_train.txt and subject_test.txt are row-bound into the Subject data frame.
- y_train.txt and y_test.txt are row-bound into the Activity data frame.

Subsequently, the script merges and subsets the data thus:
- Only the columns of the X data frame corresponding to the mean() or std() of a measurement are selected (by using regex search on the column name)
- The Subject, Activity and X data frames are column-bound into the firstTidyDataSet data frame.
- Using aggregation, the secondTidyDataSet is created from the first by grouping by subject and activity and then applying the mean function on the grouped data.
