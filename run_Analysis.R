#' You should create one R script called run_analysis.R that does the following. 
#' 1. Merges the training and the test sets to create one data set.
#' 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#' 3. Uses descriptive activity names to name the activities in the data set
#' 4. Appropriately labels the data set with descriptive variable names. 
#' 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#' Remove temporary/intermediate files created for this analysis.
removeTempFiles <- function()
{
    file.remove( "meanstd_test.csv" )
    file.remove( "meanstd_train.csv" )
    unlink( "UCI HAR Dataset", recursive = TRUE )
}

#' Merges test and train csv files generated after extracting the relevant
#' variables (i.e. executing "readData" function).
#' 
#' This function requires the following files to be available:
#'  - meanstd_test.csv
#'  - meanstd_train.csv
mergeFiles <- function()
{
    testData <- read.csv( "meanstd_test.csv" )
    trainData <- read.csv( "meanstd_train.csv" )
    
    mergedData <- rbind( testData, trainData )
    for( i in 1:length( mergedData$activity ) )
    {
        mergedData$activity[i] <- as.character( 
            activities$V2[ as.integer(mergedData$activity[i]) ] )
    }
    write.csv( mergedData, "tidyData.csv", row.names=FALSE )
    
    invisible( rbind( testData, trainData ) )
}

#' Loads the activities file passed as parameter.
readActivities <- function( fileName )
{
    activities <- read.table( fileName, sep=" " )
}

#' Obtains the statistics for the data frame passed as parameter:
#'  - mean
#'  - standar deviation.
#' 
#' Results are grouped by activity and subject.
statistics <- function( dataFrame )
{
    reqFeatures <- data.frame( values=numeric() )
    
    for( subject in 1:30 )
    {
        bySub <- data[ data$subject==subject, ]
        reqFeatures <- rbind( reqFeatures,
            sapply( bySub, tapply, bySub$activity, mean, na.rm=TRUE ) )
    }
    for( i in 1:length( reqFeatures$activity ) )
    {
        reqFeatures$activity[i] <- as.character( 
            activities$V2[ as.integer(reqFeatures$activity[i]) ] )
    }
    write.csv( reqFeatures, "averages.csv", row.names=FALSE )
    
    invisible( reqFeatures )
}

#' Processes the data from the specified file. It joins the subject, the 
#' activity and the mean/standard deviation values.
readData <- function( type, datafileName, activityfileName, subjectfileName )
{
    activityFile <- file( paste( "UCI HAR Dataset/", type, "/y_", type, ".txt", sep="" ) )
    subjectFile <- file( paste( "UCI HAR Dataset/", type, "/subject_", type, ".txt", sep="" ) )
    dataFile <- file( paste( "UCI HAR Dataset/", type, "/X_", type, ".txt", sep="" ) )
    reqFeaturesNames <- c( "subject", "activity", "tBodyAcc-mean()-X", 
                           "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", 
                           "tBodyAcc-std()-X", "tBodyAcc-std()-Y", 
                           "tBodyAcc-std()-Z",
                           "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y",
                           "tGravityAcc-mean()-Z", "tGravityAcc-std()-X",
                           "tGravityAcc-std()-Y",  "tGravityAcc-std()-Z" )
    
    
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
                    c(as.integer( subject ), 
                        activities$V2[as.integer( activity )],
                        features[ c(1:6+2, 41:46+2) ]) ) 
                        # +2 is to remove the trailing spaces at the beggining 
                        # of each row.
    }
    
    names(reqFeatures) <- reqFeaturesNames
    write.csv( reqFeatures, file=paste( "meanstd_", type, ".csv", sep="" ),
               row.names=FALSE)
    
    close( dataFile )
    close( subjectFile )
    close( activityFile )
    
    invisible( reqFeatures )
}



# #' Download raw data file.
cat( "Downloading data file (this will take a while)...\n" )
invisible( download.file( "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
               "data.zip", method="curl" ) )
cat( "Unzipping data file...")
unzip( "data.zip" )
readActivities( "UCI HAR Dataset/activity_labels.txt\n" )

# #' Read test and train files:
cat( "Processing test set...\n" )
data <- readData( "test" )
cat( "Processing train set...\n" )
data <- readData( "train" )

cat( "Merging test and training sets..." )
data <- mergeFiles()
cat( "\tOutput file:    ", getwd(), " tidyData.csv\n" )

statistics( data )
cat( "\tSee statistics: ", getwd(), " averages.csv\n" )

removeTempFiles()
cat( "Done.\n" )
