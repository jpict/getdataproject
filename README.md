README

Description:
The script run_analysis.R creates summary statistics from smartphone accelerometer data. Specifically the mean of each measurement broken down by subject and activity (e.g. walking). The script should be run from the directory where the data was unzipped.

Output:
accelSummary.csv

Packages:
dplyr

Process:
-Read in x (measurements), y (activity), and subj (subject) for both the test and training data sets, using column names from features.txt.
-Merge x, y, and subj.
-Using labels in activity_labels.txt, convert y to descriptive names (activities).
-Subset x to only mean and standard deviation values.
-Merge activities, subj, and x into one data frame.
-Group by activity and subject, and take mean across this grouping.
-Output data to text file.