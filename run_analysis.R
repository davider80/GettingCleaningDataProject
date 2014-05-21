#-------------------------------------------------------------------------------
# Merges the training and the test sets to create one data set.
#-------------------------------------------------------------------------------

#Load required libraries
library(reshape2)

# Read activity and feature labels
activity_labels <- read.table("./data/activity_labels.txt", quote="\"")
features <- read.table("./data/features.txt", quote="\"")

# Read test data
x.test <- read.table("./data/test/X_test.txt", quote="\"")
y.test <- read.table("./data/test/y_test.txt", quote="\"")
subject.test <- read.table("./data/test/subject_test.txt", quote="\"")

# Read train data
x.train <- read.table("./data/train/X_train.txt", quote="\"")
y.train <- read.table("./data/train/y_train.txt", quote="\"")
subject.train <- read.table("./data/train/subject_train.txt", quote="\"")

# Merge test and train data
x <- rbind(x.test, x.train)
y <- rbind(y.test, y.train)
subject <- rbind(subject.test, subject.train)

colnames(y) <- "id"
colnames(subject) <- "id"

#-------------------------------------------------------------------------------
# Extracts only the measurements on the mean and standard deviation for 
# each measurement.
#-------------------------------------------------------------------------------
# Find mean and std variables
selected_variables <- grep(".*mean\\(\\)|.*std\\(\\)", features[,2])

# Subset using only mean and std variables
x <- x[,selected_variables]

#-------------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------------

y$activity.name <- activity_labels[y[,1],2]

#-------------------------------------------------------------------------------
# Appropriately labels the data set with descriptive activity names
# 
# We follow this guideline:
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
#-------------------------------------------------------------------------------

# Labels variables using features dataframe
colnames(x) <- features[selected_variables, 2]

# Fix variables names following the naming guidelines
colnames(x) <- gsub("()-",".",colnames(x),fixed=TRUE)
colnames(x) <- gsub("()","",colnames(x),fixed=TRUE)
colnames(x) <- gsub("-",".",colnames(x),fixed=TRUE)

# Creates tidy data set by merging subject, activity and x dataframe
tidy <- cbind(subject$id, y$activity.name, x)
colnames(tidy) <- c("subject","activity",colnames(x))

#-------------------------------------------------------------------------------
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 
#-------------------------------------------------------------------------------

# Melts the tidy dataset by subject and activity
tidy.mean.melted <- melt(tidy, id=c("subject", "activity"))

# Casts the melted dataset by calculating the average of each variable
tidy.mean <- dcast(tidy.mean.melted, subject + activity ~ variable, mean)

#-------------------------------------------------------------------------------
# Exports the tidy dataset to TAB formatted text file
#-------------------------------------------------------------------------------
write.table(tidy.mean, "tidy.csv", sep="\t", row.names=FALSE) 
