library(dplyr)

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

subject_total <- rbind(subject_train, subject_test)
names(subject_total) = "subject"

x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)


y_total <- cbind(y_total, activity_labels[y_total$V1, 2])
feature_names <- read.table("UCI HAR Dataset/features.txt")


names(x_total) <- feature_names[, 2]
names(y_total) <- c("activityId", "activityLabel")


extracted_x_total <- cbind(x_total[, grep("mean[()]|std", names(x_total))], y_total, subject_total)
extracted_x_total <- select(extracted_x_total, -activityId)

final_tidy_dataset <- aggregate(. ~subject + activityLabel, extracted_x_total, mean)

write.table(final_tidy_dataset, file = "final_tidy_dataset.txt")


