---
title: "CodeBook"
author: "Axel Garcia"
date: "March 15, 2015"
output: html_document
---

any transformations or work that you performed to clean up the data called CodeBook.md






## Study Desgin
Download datat from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (1)

Getting data from that link has been requested by the course instructor. The data is of Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors[Anguita, 2013]. A more detailed description can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones (2)

The analyzed data contains only the mean and standard deviation data gotten from the data corpus provided in link number 1 above. That data selection is being made upon instructor request.

## Code Book
Variables were tidied based on the comments of the following link: 
https://github.com/jtleek/datasharing (3)

average of each variable for each activity and each subject


Variable | unit | Description
---------|------|----------------
Activity | Categorical:<br />Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying down.| The activity this observation represents.
Subjects|Categorical:<br />1..30 | Identifier of the subject the data was measured from.
1 tBodyAcc-mean()-X|Continuous:<br />g (9.81 m/s^2^) | Mean in X of the body acceleration.
2 tBodyAcc-mean()-Y|Continuous:<br />g (9.81 m/s^2^) | Mean in Y of the body acceleration.
3 tBodyAcc-mean()-Z|Continuous:<br />g (9.81 m/s^2^) | Mean in Z of the body acceleration.
4 tBodyAcc-std()-X|Continuous:<br />g (9.81 m/s^2^) | Standard deviation in X of the body acceleration.
5 tBodyAcc-std()-Y|Continuous:<br />g (9.81 m/s^2^) | Standard deviation in Y of the body acceleration.
6 tBodyAcc-std()-Z|Continuous:<br />g (9.81 m/s^2^) | Standard deviation in Z of the body acceleration.




# References
[Anguita, 2013] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.