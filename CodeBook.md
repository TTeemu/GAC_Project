# code book 
##Variable descriptions 
Final data set consists from mean and std samsung activity data. The X,Y and Z means directions measured from the sensors.
the original data is data collected from different mobilephone sensors which is then normalized. more information about the original data set can be found from the url below.

##The data 
the base data used for the process is from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

from this independent tidy data set with the average of each variable for each activity and each subject was created.

##Transformations or work performed to clean up the data
1. training set and testing sets were combined
2. only mean and standard deviation measures variables were chosen
3. variable names cleaned
4. activity labels changed from numbers to labels
5. mean values were calculated for each subject and for each activity type
6. new dataset was saved in comb_data.txt

## Further details about the process can be seen from comments in the R script
