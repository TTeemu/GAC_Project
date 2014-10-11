## run_analysis.R ##

# 1) Merges the training and the test sets to create one data set.

###################### LOADING IN DATA ##########################
## Load in both data sets ##
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
##  variable names
features <- read.table("./UCI HAR Dataset/features.txt")

## Subject information ##
test_subj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")  

## labels for datasets ##
test_lab <- read.table("./UCI HAR Dataset/test/Y_test.txt")
train_lab <- read.table("./UCI HAR Dataset/train/Y_train.txt")  

#################################################################

## adding variable names to the dataframes ##
names(test) <- features[,2]
names(train) <- features[,2]

## adding labels to activities  and adding the variable name ##
test <- cbind(test_lab,test)
train <- cbind(train_lab,train)
names(test)[1] <- "activity_labels"
names(train)[1] <- "activity_labels"

## adding the subject id´s to the dataframe ##
test <- cbind(test_subj,test)
train <- cbind(train_subj,train)
names(test)[1] <- "id"
names(train)[1] <- "id"

### combining training and testing sets ###
whole_data <- rbind(train,test)

## removing redundant dataframes ##
remove(features,test_lab,test_subj,test,train,train_lab,train_subj)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# which columns contains mean and std data
whole_data <-  whole_data[,c(1,2,grep("std",names(whole_data)),grep("mean",names(whole_data)))]
whole_data <- whole_data[,-grep("meanFreq",names(whole_data))]

# 3) Uses descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities <- activities[,2]

for(i in 1:6){
  whole_data[,2] <- gsub(i,activities[i],whole_data[,2])
}


# 4) Appropriately labels the data set with descriptive variable names. 
# cleaning the variable names () -> ""
names(whole_data) <- gsub("\\()","",names(whole_data))
# changing the variable names to lower case letters
names(whole_data) <- tolower(names(whole_data))

# 5) From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.
comb_data <- aggregate(whole_data[, 3:ncol(whole_data)],
                       by=list(subject_id = whole_data$id, 
                               activity_label = whole_data$activity_labels),
                       mean)

## writing uploadable data ##
write.table(comb_data,"comb_data.txt",row.names=F)
