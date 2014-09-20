# Constant properties
ARCHIVE_URL <- paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectf",
                     "iles%2FUCI%20HAR%20Dataset.zip", sep = "", collapse = "")
ACTIVITY_LABELS_PATH <- "UCI HAR Dataset/activity_labels.txt"
ARCHIVE_PATH <- "UCI HAR Dataset.zip"
FEATURES_PATH <- "UCI HAR Dataset/features.txt"
OUTPUT_PATH <- "tidy.txt"
SUBJECT_TEST_PATH <- "UCI HAR Dataset/test/subject_test.txt"
SUBJECT_TRAIN_PATH <- "UCI HAR Dataset/train/subject_train.txt"
X_TEST_PATH <- "UCI HAR Dataset/test/X_test.txt"
X_TRAIN_PATH <- "UCI HAR Dataset/train/X_train.txt"
Y_TEST_PATH <- "UCI HAR Dataset/test/y_test.txt"
Y_TRAIN_PATH <- "UCI HAR Dataset/train/y_train.txt"
ARCHIVE_FILES <- c(ACTIVITY_LABELS_PATH, FEATURES_PATH, SUBJECT_TRAIN_PATH,
                   SUBJECT_TEST_PATH, X_TEST_PATH, X_TRAIN_PATH, Y_TEST_PATH,
                   Y_TRAIN_PATH)

# Extract necessary files from archive
for (filename in ARCHIVE_FILES) {
  if (!file.exists(filename)) {
    # Download zip archive
    if (!file.exists(ARCHIVE_PATH)) {
      print("Downloading data archive...")
      download.file(ARCHIVE_URL, ARCHIVE_PATH)
    }
    print(paste("Unzipping ", filename, "...", sep = "", collapse = ""))
    unzip(ARCHIVE_PATH, filename)
  }
}

# Read and merge activity data sets.
print("Reading activities...")
Activity <- rbind(read.table(Y_TRAIN_PATH), read.table(Y_TEST_PATH))

# Replace ids with activity names read from "activity_labels.txt".
Activity <- merge(Activity, read.table(ACTIVITY_LABELS_PATH), by.x = 1,
                  by.y = 1)[,2]

# Read and merge subject subject data sets.
print("Reading subjects...")
Subject <- rbind(read.table(SUBJECT_TRAIN_PATH), 
                 read.table(SUBJECT_TEST_PATH))[,1]

# Read and merge X data sets.
print("Reading data...")
X <- rbind(read.table(X_TRAIN_PATH), read.table(X_TEST_PATH))

# Read features, format names and apply them to the X dataset column names.
print("Reading features...")
colnames(X) <- gsub("_$", "",
                    gsub("[-,\\(\\)]+", "_",
                         read.table(FEATURES_PATH,
                                    colClasses = "character")[,2]))

# Extract only mean() and std() of the measurements. Reject meanFreq() as per
# discussion in forum.
print("Extracting means and standard deviations...")
X <- X[,grep("^.*(mean|std)(_[[:upper:]])?$", colnames(X))]

# Merge Subject, Activity and X (data) into a single data set.
print("Creating first tidy data set...")
firstTidyDataSet <- cbind(Subject, Activity, X)

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
print("Creating second tidy data set...")
secondTidyDataSet <- aggregate(firstTidyDataSet[,-(1:2)],
                               by = firstTidyDataSet[,1:2], FUN = sd)
# Write the second tidy data set to file
print(paste("Writing second tidy data set to ", OUTPUT_PATH ," ...", sep = "",
            collapse = ""))
write.table(secondTidyDataSet, OUTPUT_PATH, row.names = FALSE)

# Cleanup after execution, leave only the 2 required tidy data sets
rm(Activity, ACTIVITY_LABELS_PATH, ARCHIVE_FILES, ARCHIVE_PATH, ARCHIVE_URL,
   FEATURES_PATH, filename, OUTPUT_PATH, Subject, SUBJECT_TEST_PATH,
   SUBJECT_TRAIN_PATH, X, X_TEST_PATH, X_TRAIN_PATH, Y_TEST_PATH, Y_TRAIN_PATH)

print("Done!")