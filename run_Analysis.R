#' You should create one R script called run_analysis.R that does the following. 
#' 1. Merges the training and the test sets to create one data set.
#' 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#' 3. Uses descriptive activity names to name the activities in the data set
#' 4. Appropriately labels the data set with descriptive variable names. 
#' 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# #' Download raw data file.
download.file( "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
               "data.zip", method="curl" )
unzip( "data.zip", list=TRUE )

# #' Read test file:
readActivities( "UCI HAR Dataset/activity_labels.txt" )
data <- readData( "UCI HAR Dataset/test/X_test.txt", 
          "UCI HAR Dataset/test/y_test.txt",
          "UCI HAR Dataset/test/subject_test.txt")

statistics( data )


readActivities <- function( fileName )
{
    activities <- read.table( fileName, sep=" " )
}

statistics( dataFrame )
{
    stats <- sapply( f, mean, na.rm=TRUE )
    
    write.csv( stats, "" )
}

readData <- function( datafileName, activityfileName, subjectfileName )
{
    activityFile <- file( activityfileName )
    subjectFile <- file( subjectfileName )
    dataFile <- file( datafileName )
    reqFeatures <- numeric(8)
    reqFeaturesNames <- c( "activity", "subject", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z")
    
    reqFeatures <- data.frame( values=numeric() )
    
    open( activityFile )
    open( subjectFile )
    open( dataFile )
    
    while ( length(line <- readLines( dataFile, n=1, warn=FALSE )) > 0 )
    {
        
        activity <- readLines( activityFile, n=1, warn=FALSE )
        subject <- readLines( subjectFile, n=1, warn=FALSE )
        features <- as.numeric( unlist( strsplit( line, split=" " ), recursive=TRUE ) )
        reqFeatures <- rbind( reqFeatures, 
                              c(activities$V2[as.integer( activity )], 
                                as.integer( subject ),
                                features[ c(1:6+2) ]) )

#data.frame( activity=activities$V2[as.integer( activity )], 
#            subject=as.integer( subject ),
#            features[ c(1:6) ]
    }
    
    names(reqFeatures) <- reqFeaturesNames
    write.csv( reqFeatures, file="tidy.csv", col.names=TRUE )
    
    close( dataFile )
    close( subjectFile )
    close( activityFile )

    invisible( reqFeatures )
}