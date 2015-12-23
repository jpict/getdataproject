# This script:
# -Merges the training and the test sets to create one data set.
# -Extracts only the measurements on the mean and standard deviation for each measurement. 
# -Uses descriptive activity names to name the activities in the data set
# -Appropriately labels the data set with descriptive variable names. 
# -From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject.

library(dplyr)

# get column names
colnames <- read.table('./features.txt')
colnames <- as.character(colnames[,2])

# read test data
subjtestfile <- './test/subject_test.txt'
subjtest     <- read.table(subjtestfile,col.names = "subject")
xtestfile    <- './test/X_test.txt'
xtest        <- read.table(xtestfile,col.names = colnames)
ytestfile    <- './test/Y_test.txt'
ytest        <- read.table(ytestfile, col.names = "activity")

# read training data
subjtrainfile <- './train/subject_train.txt'
subjtrain     <- read.table(subjtrainfile,col.names = "subject")
xtrainfile    <- './train/X_train.txt'
xtrain        <- read.table(xtrainfile,col.names = colnames)
ytrainfile    <- './train/Y_train.txt'
ytrain        <- read.table(ytrainfile,col.names = "activity")

# combine test and train
x    <- rbind(xtrain,xtest)
y    <- rbind(ytrain,ytest)
subj <- rbind(subjtrain,subjtest)

# label activities
actLabels  <- read.table('./activity_labels.txt')
actLabels  <- actLabels[,2]
activities <- data.frame(activity = actLabels[y[,1]])

# subset x to only mean and std data
imean <- grep('mean()',colnames)
istd <- grep('std()',colnames)
x <- x[,c(imean,istd)]

# merge into one table
accelData <- cbind(activities,subj,x)

# group by activity and subject and take mean
grouped      <- group_by(accelData,activity,subject)
accelSummary <- summarize_each(grouped,funs(mean))

# write data
write.table(accelSummary, file = "accelSummary.csv", row.names = FALSE)
