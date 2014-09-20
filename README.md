getdata_course_project
======================

This course project for Coursera "Getting and Cleaning Data" course (getdata-007) consists of a single script, "run_Analysis.R", the code book ("CodeBook.md") and the current file ("README.md").

To use this product, simply download the "run_Analysis.R" into your R workspace and, from the R console, type "source("run_Analysis.R").

The script requires data files to run correctly, there are 3 options to proceed. Either you provide the data files ("*.txt") directly, only the archive ("UCI HAR Dataset.zip"), or none in which case the script will download the appropriate data provided you have a valid Internet connection. Careful: the file is of considerable size, if you have already downloaded it it is highly recommended that you place it in the workspace directory before running the script.

Here is the logic behind the procurement of the data: 
- If the data files ("*.txt") are not found in the "UCI HAR Dataset" subdirectory in the workspace, the script looks for the "UCI HAR Dataset.zip" archive from which it will extract them.
- If the "UCI HAR Dataset.zip" archive is not found in the root directory of the workspace, the script will download it prior to extracting the appropriate data files.

After running the script, your R console will retain the 2 tidy data sets described in the project's presentation and will have created a file called "tidy.txt" containing the second tidy data set which can later be reloaded into memory using the following command:

var <- read.table("tidy.txt", TRUE)
