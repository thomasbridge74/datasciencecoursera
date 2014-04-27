# This script runs the commands to merge the two data sets.

run_analysis <- function() {
  
# The assumption is we're in the root folder of the data set.   Further,
# I am explicitly assuming that we have already downloaded and unzipped the 
# data file.

# 1. Merges the training and the test sets to create one data set.

# First, read in the data from the files - training and subtraining.

# The detailed names for the 561 variables are in the file features.txt
# additionally for each set of observations we need to add the test subject and
# their ticket reference.

colNames <- read.table("features.txt")
training_data <- read.table("train/X_train.txt", col.names = colNames$V2)
train_sub <- read.table("train/subject_train.txt")
training_data$subject <- train_sub$V1
train_activity <- read.table("train/y_train.txt")
training_data$activity <- train_activity$V1

testing_data <- read.table("test/X_test.txt", col.names = colNames$V2)
test_sub <- read.table("test/subject_test.txt")
testing_data$subject <- test_sub$V1
test_activity <- read.table("test/y_test.txt")
testing_data$activity <- test_activity$V1

# now merge the data.    As the two data sets are identical, we can do this relatively
# easily by simply rbinding the two datasets together.

jointdata <- rbind(testing_data,training_data)

# 2. Extracts only the measurements on the mean and standard deviation for 
#   each measurement. 

# The variable headers are typically of the form "<name>.<type>...N" where <name> is
# the variable name, <type> represents the statistical summary (such as mean, std, max
# etc)   
# The below command creates a subset of the headers containing mean and std (but 
# explicitly excluding MeanFreq type variables and uses them along with subject and
# activity fields to create a new frame meeting the requirement)

means_and_stds <- jointdata[, c("subject", "activity", names(jointdata)[grep("mean\\.|std", names(jointdata))])]

# 3. Uses descriptive activity names to name the activities in the data set

# As discussed in the forums, this is a little and ambigious combined with Step 4.
# I am interpreting this as a requirement to reading the activity labels

activity_labels <- read.table("activity_labels.txt", col.names = c("id", "text"))

# 4. Appropriately labels the data set with descriptive activity names. 

means_and_stds <- merge(means_and_stds, activity_labels, by.x="activity", by.y="id")
means_and_stds$activity <- NULL

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 

melted_means <- melt(means_and_stds, id=c("subject", "text"))
means_summary <- dcast(melted_means, subject + text ~ variable, mean)
}
