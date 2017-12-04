---
title: "CodeBook"
output: html_document
---

# Getting and Cleaning Data

```r
setwd("~/datasciencecoursera/getting-and-cleaningdata")
getwd()
```

```
## [1] "/Users/jaimatharoo/datasciencecoursera/getting-and-cleaningdata"
```

```r
dir()
```

```
## [1] "CodeBook.html"        "CodeBook.md"          "CodeBook.Rmd"        
## [4] "README.txt"           "run_analysis.R"       "tidydata_average.txt"
## [7] "tidydata.txt"         "UCI HAR Dataset"
```

```r
## Read and Merge features training and test data sets
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- rbind(X_train, X_test)


## Read and Merge activities test and training data sets
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
activities <- rbind(y_train, y_test)

## Read and Merge subject's data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)


## Extracts only the measurements on the mean and standard deviation for each measurement
featurescol <- read.table("UCI HAR Dataset/features.txt")
mean.sd <- grep("-mean\\(\\)|-std\\(\\)", featurescol[, 2])
features.mean.sd <- features[, mean.sd]


## Assign descriptive activity names to name the activities in the data set
names(subject)<-c("subject")
names(activities)<- c("activity")
names(features.mean.sd)<- featurescol[mean.sd,2]
names(features.mean.sd) <- tolower(names(features.mean.sd)) 
names(features.mean.sd) <- gsub("\\(|\\)", "", names(features.mean.sd))

actlabels <- read.table('UCI HAR Dataset/activity_labels.txt')
actlabels[, 2] <- tolower(as.character(actlabels[, 2]))
actlabels[, 2] <- gsub("_", "", actlabels[, 2])
activities[,1] = factor(activities[,1],labels=actlabels[,2])

# Merge data set with descriptive activity names.
tidydata <- cbind(features.mean.sd,subject, activities)
names(tidydata)<-gsub("^t", "time", names(tidydata))
names(tidydata)<-gsub("^f", "frequency", names(tidydata))
```

### List of Variables in dataframe

```r
str(tidydata)
```

```
## 'data.frame':	10299 obs. of  68 variables:
##  $ timebodyacc-mean-x               : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ timebodyacc-mean-y               : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ timebodyacc-mean-z               : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ timebodyacc-std-x                : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ timebodyacc-std-y                : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ timebodyacc-std-z                : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##  $ timegravityacc-mean-x            : num  0.963 0.967 0.967 0.968 0.968 ...
##  $ timegravityacc-mean-y            : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
##  $ timegravityacc-mean-z            : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
##  $ timegravityacc-std-x             : num  -0.985 -0.997 -1 -0.997 -0.998 ...
##  $ timegravityacc-std-y             : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
##  $ timegravityacc-std-z             : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
##  $ timebodyaccjerk-mean-x           : num  0.078 0.074 0.0736 0.0773 0.0734 ...
##  $ timebodyaccjerk-mean-y           : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
##  $ timebodyaccjerk-mean-z           : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
##  $ timebodyaccjerk-std-x            : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
##  $ timebodyaccjerk-std-y            : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
##  $ timebodyaccjerk-std-z            : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
##  $ timebodygyro-mean-x              : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
##  $ timebodygyro-mean-y              : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
##  $ timebodygyro-mean-z              : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
##  $ timebodygyro-std-x               : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
##  $ timebodygyro-std-y               : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
##  $ timebodygyro-std-z               : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
##  $ timebodygyrojerk-mean-x          : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
##  $ timebodygyrojerk-mean-y          : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
##  $ timebodygyrojerk-mean-z          : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
##  $ timebodygyrojerk-std-x           : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
##  $ timebodygyrojerk-std-y           : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
##  $ timebodygyrojerk-std-z           : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
##  $ timebodyaccmag-mean              : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
##  $ timebodyaccmag-std               : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
##  $ timegravityaccmag-mean           : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
##  $ timegravityaccmag-std            : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
##  $ timebodyaccjerkmag-mean          : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
##  $ timebodyaccjerkmag-std           : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
##  $ timebodygyromag-mean             : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
##  $ timebodygyromag-std              : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
##  $ timebodygyrojerkmag-mean         : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
##  $ timebodygyrojerkmag-std          : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
##  $ frequencybodyacc-mean-x          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
##  $ frequencybodyacc-mean-y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
##  $ frequencybodyacc-mean-z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
##  $ frequencybodyacc-std-x           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
##  $ frequencybodyacc-std-y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
##  $ frequencybodyacc-std-z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
##  $ frequencybodyaccjerk-mean-x      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
##  $ frequencybodyaccjerk-mean-y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
##  $ frequencybodyaccjerk-mean-z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
##  $ frequencybodyaccjerk-std-x       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
##  $ frequencybodyaccjerk-std-y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
##  $ frequencybodyaccjerk-std-z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
##  $ frequencybodygyro-mean-x         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
##  $ frequencybodygyro-mean-y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
##  $ frequencybodygyro-mean-z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
##  $ frequencybodygyro-std-x          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
##  $ frequencybodygyro-std-y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
##  $ frequencybodygyro-std-z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
##  $ frequencybodyaccmag-mean         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
##  $ frequencybodyaccmag-std          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
##  $ frequencybodybodyaccjerkmag-mean : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
##  $ frequencybodybodyaccjerkmag-std  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
##  $ frequencybodybodygyromag-mean    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
##  $ frequencybodybodygyromag-std     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
##  $ frequencybodybodygyrojerkmag-mean: num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
##  $ frequencybodybodygyrojerkmag-std : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
##  $ subject                          : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity                         : Factor w/ 6 levels "walking","walkingupstairs",..: 5 5 5 5 5 5 5 5 5 5 ...
```
### Sample of data

```r
head(tidydata)
```

```
##   timebodyacc-mean-x timebodyacc-mean-y timebodyacc-mean-z
## 1          0.2885845        -0.02029417         -0.1329051
## 2          0.2784188        -0.01641057         -0.1235202
## 3          0.2796531        -0.01946716         -0.1134617
## 4          0.2791739        -0.02620065         -0.1232826
## 5          0.2766288        -0.01656965         -0.1153619
## 6          0.2771988        -0.01009785         -0.1051373
##   timebodyacc-std-x timebodyacc-std-y timebodyacc-std-z
## 1        -0.9952786        -0.9831106        -0.9135264
## 2        -0.9982453        -0.9753002        -0.9603220
## 3        -0.9953796        -0.9671870        -0.9789440
## 4        -0.9960915        -0.9834027        -0.9906751
## 5        -0.9981386        -0.9808173        -0.9904816
## 6        -0.9973350        -0.9904868        -0.9954200
##   timegravityacc-mean-x timegravityacc-mean-y timegravityacc-mean-z
## 1             0.9633961            -0.1408397            0.11537494
## 2             0.9665611            -0.1415513            0.10937881
## 3             0.9668781            -0.1420098            0.10188392
## 4             0.9676152            -0.1439765            0.09985014
## 5             0.9682244            -0.1487502            0.09448590
## 6             0.9679482            -0.1482100            0.09190972
##   timegravityacc-std-x timegravityacc-std-y timegravityacc-std-z
## 1           -0.9852497           -0.9817084           -0.8776250
## 2           -0.9974113           -0.9894474           -0.9316387
## 3           -0.9995740           -0.9928658           -0.9929172
## 4           -0.9966456           -0.9813928           -0.9784764
## 5           -0.9984293           -0.9880982           -0.9787449
## 6           -0.9989793           -0.9867539           -0.9973064
##   timebodyaccjerk-mean-x timebodyaccjerk-mean-y timebodyaccjerk-mean-z
## 1             0.07799634            0.005000803           -0.067830808
## 2             0.07400671            0.005771104            0.029376633
## 3             0.07363596            0.003104037           -0.009045631
## 4             0.07732061            0.020057642           -0.009864772
## 5             0.07344436            0.019121574            0.016779979
## 6             0.07793244            0.018684046            0.009344434
##   timebodyaccjerk-std-x timebodyaccjerk-std-y timebodyaccjerk-std-z
## 1            -0.9935191            -0.9883600            -0.9935750
## 2            -0.9955481            -0.9810636            -0.9918457
## 3            -0.9907428            -0.9809556            -0.9896866
## 4            -0.9926974            -0.9875527            -0.9934976
## 5            -0.9964202            -0.9883587            -0.9924549
## 6            -0.9948136            -0.9887145            -0.9922663
##   timebodygyro-mean-x timebodygyro-mean-y timebodygyro-mean-z
## 1        -0.006100849         -0.03136479          0.10772540
## 2        -0.016111620         -0.08389378          0.10058429
## 3        -0.031698294         -0.10233542          0.09612688
## 4        -0.043409983         -0.09138618          0.08553770
## 5        -0.033960416         -0.07470803          0.07739203
## 6        -0.028775508         -0.07039311          0.07901214
##   timebodygyro-std-x timebodygyro-std-y timebodygyro-std-z
## 1         -0.9853103         -0.9766234         -0.9922053
## 2         -0.9831200         -0.9890458         -0.9891212
## 3         -0.9762921         -0.9935518         -0.9863787
## 4         -0.9913848         -0.9924073         -0.9875542
## 5         -0.9851836         -0.9923781         -0.9874019
## 6         -0.9851808         -0.9921175         -0.9830768
##   timebodygyrojerk-mean-x timebodygyrojerk-mean-y timebodygyrojerk-mean-z
## 1             -0.09916740             -0.05551737             -0.06198580
## 2             -0.11050283             -0.04481873             -0.05924282
## 3             -0.10848567             -0.04241031             -0.05582883
## 4             -0.09116989             -0.03633262             -0.06046466
## 5             -0.09077010             -0.03763253             -0.05828932
## 6             -0.09424758             -0.04335526             -0.04193600
##   timebodygyrojerk-std-x timebodygyrojerk-std-y timebodygyrojerk-std-z
## 1             -0.9921107             -0.9925193             -0.9920553
## 2             -0.9898726             -0.9972926             -0.9938510
## 3             -0.9884618             -0.9956321             -0.9915318
## 4             -0.9911194             -0.9966410             -0.9933289
## 5             -0.9913545             -0.9964730             -0.9945110
## 6             -0.9916216             -0.9960147             -0.9930906
##   timebodyaccmag-mean timebodyaccmag-std timegravityaccmag-mean
## 1          -0.9594339         -0.9505515             -0.9594339
## 2          -0.9792892         -0.9760571             -0.9792892
## 3          -0.9837031         -0.9880196             -0.9837031
## 4          -0.9865418         -0.9864213             -0.9865418
## 5          -0.9928271         -0.9912754             -0.9928271
## 6          -0.9942950         -0.9952490             -0.9942950
##   timegravityaccmag-std timebodyaccjerkmag-mean timebodyaccjerkmag-std
## 1            -0.9505515              -0.9933059             -0.9943364
## 2            -0.9760571              -0.9912535             -0.9916944
## 3            -0.9880196              -0.9885313             -0.9903969
## 4            -0.9864213              -0.9930780             -0.9933808
## 5            -0.9912754              -0.9934800             -0.9958537
## 6            -0.9952490              -0.9930177             -0.9954243
##   timebodygyromag-mean timebodygyromag-std timebodygyrojerkmag-mean
## 1           -0.9689591          -0.9643352               -0.9942478
## 2           -0.9806831          -0.9837542               -0.9951232
## 3           -0.9763171          -0.9860515               -0.9934032
## 4           -0.9820599          -0.9873511               -0.9955022
## 5           -0.9852037          -0.9890626               -0.9958076
## 6           -0.9858944          -0.9864403               -0.9952748
##   timebodygyrojerkmag-std frequencybodyacc-mean-x frequencybodyacc-mean-y
## 1              -0.9913676              -0.9947832              -0.9829841
## 2              -0.9961016              -0.9974507              -0.9768517
## 3              -0.9950910              -0.9935941              -0.9725115
## 4              -0.9952666              -0.9954906              -0.9835697
## 5              -0.9952580              -0.9972859              -0.9823010
## 6              -0.9952050              -0.9966567              -0.9869395
##   frequencybodyacc-mean-z frequencybodyacc-std-x frequencybodyacc-std-y
## 1              -0.9392687             -0.9954217             -0.9831330
## 2              -0.9735227             -0.9986803             -0.9749298
## 3              -0.9833040             -0.9963128             -0.9655059
## 4              -0.9910798             -0.9963121             -0.9832444
## 5              -0.9883694             -0.9986065             -0.9801295
## 6              -0.9927386             -0.9976438             -0.9922637
##   frequencybodyacc-std-z frequencybodyaccjerk-mean-x
## 1             -0.9061650                  -0.9923325
## 2             -0.9554381                  -0.9950322
## 3             -0.9770493                  -0.9909937
## 4             -0.9902291                  -0.9944466
## 5             -0.9919150                  -0.9962920
## 6             -0.9970459                  -0.9948507
##   frequencybodyaccjerk-mean-y frequencybodyaccjerk-mean-z
## 1                  -0.9871699                  -0.9896961
## 2                  -0.9813115                  -0.9897398
## 3                  -0.9816423                  -0.9875663
## 4                  -0.9887272                  -0.9913542
## 5                  -0.9887900                  -0.9906244
## 6                  -0.9882443                  -0.9901575
##   frequencybodyaccjerk-std-x frequencybodyaccjerk-std-y
## 1                 -0.9958207                 -0.9909363
## 2                 -0.9966523                 -0.9820839
## 3                 -0.9912488                 -0.9814148
## 4                 -0.9913783                 -0.9869269
## 5                 -0.9969025                 -0.9886067
## 6                 -0.9952180                 -0.9901788
##   frequencybodyaccjerk-std-z frequencybodygyro-mean-x
## 1                 -0.9970517               -0.9865744
## 2                 -0.9926268               -0.9773867
## 3                 -0.9904159               -0.9754332
## 4                 -0.9943908               -0.9871096
## 5                 -0.9929065               -0.9824465
## 6                 -0.9930667               -0.9848902
##   frequencybodygyro-mean-y frequencybodygyro-mean-z
## 1               -0.9817615               -0.9895148
## 2               -0.9925300               -0.9896058
## 3               -0.9937147               -0.9867557
## 4               -0.9936015               -0.9871913
## 5               -0.9929838               -0.9886664
## 6               -0.9927862               -0.9807784
##   frequencybodygyro-std-x frequencybodygyro-std-y frequencybodygyro-std-z
## 1              -0.9850326              -0.9738861              -0.9940349
## 2              -0.9849043              -0.9871681              -0.9897847
## 3              -0.9766422              -0.9933990              -0.9873282
## 4              -0.9928104              -0.9916460              -0.9886776
## 5              -0.9859818              -0.9919558              -0.9879443
## 6              -0.9852871              -0.9916595              -0.9853661
##   frequencybodyaccmag-mean frequencybodyaccmag-std
## 1               -0.9521547              -0.9561340
## 2               -0.9808566              -0.9758658
## 3               -0.9877948              -0.9890155
## 4               -0.9875187              -0.9867420
## 5               -0.9935909              -0.9900635
## 6               -0.9948360              -0.9952833
##   frequencybodybodyaccjerkmag-mean frequencybodybodyaccjerkmag-std
## 1                       -0.9937257                      -0.9937550
## 2                       -0.9903355                      -0.9919603
## 3                       -0.9892801                      -0.9908667
## 4                       -0.9927689                      -0.9916998
## 5                       -0.9955228                      -0.9943890
## 6                       -0.9947329                      -0.9951562
##   frequencybodybodygyromag-mean frequencybodybodygyromag-std
## 1                    -0.9801349                   -0.9613094
## 2                    -0.9882956                   -0.9833219
## 3                    -0.9892548                   -0.9860277
## 4                    -0.9894128                   -0.9878358
## 5                    -0.9914330                   -0.9890594
## 6                    -0.9905000                   -0.9858609
##   frequencybodybodygyrojerkmag-mean frequencybodybodygyrojerkmag-std
## 1                        -0.9919904                       -0.9906975
## 2                        -0.9958539                       -0.9963995
## 3                        -0.9950305                       -0.9951274
## 4                        -0.9952207                       -0.9952369
## 5                        -0.9950928                       -0.9954648
## 6                        -0.9951433                       -0.9952387
##   subject activity
## 1       1 standing
## 2       1 standing
## 3       1 standing
## 4       1 standing
## 5       1 standing
## 6       1 standing
```
### Following code writes tidy data to a file "tidydata.txt"

```r
## write.table(tidydata, 'tidydata.txt', row.names = F)
```
### Following code creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

```r
suppressWarnings(avg_tidydata <- aggregate(tidydata, by = list(subject=tidydata$subject, activity=tidydata$activity), FUN = mean))
avg_tidydata <- avg_tidydata[1:68]
```
### List of Variables in data set created with average of each variable for each activity and each subject.

```r
str(avg_tidydata)
```

```
## 'data.frame':	180 obs. of  68 variables:
##  $ subject                          : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ activity                         : Factor w/ 6 levels "walking","walkingupstairs",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ timebodyacc-mean-x               : num  0.277 0.276 0.276 0.279 0.278 ...
##  $ timebodyacc-mean-y               : num  -0.0174 -0.0186 -0.0172 -0.0148 -0.0173 ...
##  $ timebodyacc-mean-z               : num  -0.111 -0.106 -0.113 -0.111 -0.108 ...
##  $ timebodyacc-std-x                : num  -0.284 -0.424 -0.36 -0.441 -0.294 ...
##  $ timebodyacc-std-y                : num  0.1145 -0.0781 -0.0699 -0.0788 0.0767 ...
##  $ timebodyacc-std-z                : num  -0.26 -0.425 -0.387 -0.586 -0.457 ...
##  $ timegravityacc-mean-x            : num  0.935 0.913 0.937 0.964 0.973 ...
##  $ timegravityacc-mean-y            : num  -0.2822 -0.3466 -0.262 -0.0859 -0.1004 ...
##  $ timegravityacc-mean-z            : num  -0.0681 0.08473 -0.13811 0.12776 0.00248 ...
##  $ timegravityacc-std-x             : num  -0.977 -0.973 -0.978 -0.984 -0.979 ...
##  $ timegravityacc-std-y             : num  -0.971 -0.972 -0.962 -0.968 -0.962 ...
##  $ timegravityacc-std-z             : num  -0.948 -0.972 -0.952 -0.963 -0.965 ...
##  $ timebodyaccjerk-mean-x           : num  0.074 0.0618 0.0815 0.0784 0.0846 ...
##  $ timebodyaccjerk-mean-y           : num  0.02827 0.01825 0.01006 0.00296 -0.01632 ...
##  $ timebodyaccjerk-mean-z           : num  -4.17e-03 7.90e-03 -5.62e-03 -7.68e-04 8.32e-05 ...
##  $ timebodyaccjerk-std-x            : num  -0.114 -0.278 -0.269 -0.297 -0.303 ...
##  $ timebodyaccjerk-std-y            : num  0.067 -0.0166 -0.045 -0.2212 -0.091 ...
##  $ timebodyaccjerk-std-z            : num  -0.503 -0.586 -0.529 -0.751 -0.613 ...
##  $ timebodygyro-mean-x              : num  -0.0418 -0.053 -0.0256 -0.0318 -0.0489 ...
##  $ timebodygyro-mean-y              : num  -0.0695 -0.0482 -0.0779 -0.0727 -0.069 ...
##  $ timebodygyro-mean-z              : num  0.0849 0.0828 0.0813 0.0806 0.0815 ...
##  $ timebodygyro-std-x               : num  -0.474 -0.562 -0.572 -0.501 -0.491 ...
##  $ timebodygyro-std-y               : num  -0.0546 -0.5385 -0.5638 -0.6654 -0.5046 ...
##  $ timebodygyro-std-z               : num  -0.344 -0.481 -0.477 -0.663 -0.319 ...
##  $ timebodygyrojerk-mean-x          : num  -0.09 -0.0819 -0.0952 -0.1153 -0.0888 ...
##  $ timebodygyrojerk-mean-y          : num  -0.0398 -0.0538 -0.0388 -0.0393 -0.045 ...
##  $ timebodygyrojerk-mean-z          : num  -0.0461 -0.0515 -0.0504 -0.0551 -0.0483 ...
##  $ timebodygyrojerk-std-x           : num  -0.207 -0.39 -0.386 -0.492 -0.358 ...
##  $ timebodygyrojerk-std-y           : num  -0.304 -0.634 -0.639 -0.807 -0.571 ...
##  $ timebodygyrojerk-std-z           : num  -0.404 -0.435 -0.537 -0.64 -0.158 ...
##  $ timebodyaccmag-mean              : num  -0.137 -0.29 -0.255 -0.312 -0.158 ...
##  $ timebodyaccmag-std               : num  -0.22 -0.423 -0.328 -0.528 -0.377 ...
##  $ timegravityaccmag-mean           : num  -0.137 -0.29 -0.255 -0.312 -0.158 ...
##  $ timegravityaccmag-std            : num  -0.22 -0.423 -0.328 -0.528 -0.377 ...
##  $ timebodyaccjerkmag-mean          : num  -0.141 -0.281 -0.28 -0.367 -0.288 ...
##  $ timebodyaccjerkmag-std           : num  -0.0745 -0.1642 -0.1399 -0.3169 -0.2822 ...
##  $ timebodygyromag-mean             : num  -0.161 -0.447 -0.466 -0.498 -0.356 ...
##  $ timebodygyromag-std              : num  -0.187 -0.553 -0.562 -0.553 -0.492 ...
##  $ timebodygyrojerkmag-mean         : num  -0.299 -0.548 -0.566 -0.681 -0.445 ...
##  $ timebodygyrojerkmag-std          : num  -0.325 -0.558 -0.567 -0.73 -0.489 ...
##  $ frequencybodyacc-mean-x          : num  -0.203 -0.346 -0.317 -0.427 -0.288 ...
##  $ frequencybodyacc-mean-y          : num  0.08971 -0.0219 -0.0813 -0.1494 0.00946 ...
##  $ frequencybodyacc-mean-z          : num  -0.332 -0.454 -0.412 -0.631 -0.49 ...
##  $ frequencybodyacc-std-x           : num  -0.319 -0.458 -0.379 -0.447 -0.298 ...
##  $ frequencybodyacc-std-y           : num  0.056 -0.1692 -0.124 -0.1018 0.0426 ...
##  $ frequencybodyacc-std-z           : num  -0.28 -0.455 -0.423 -0.594 -0.483 ...
##  $ frequencybodyaccjerk-mean-x      : num  -0.171 -0.305 -0.305 -0.359 -0.345 ...
##  $ frequencybodyaccjerk-mean-y      : num  -0.0352 -0.0788 -0.1405 -0.2796 -0.1811 ...
##  $ frequencybodyaccjerk-mean-z      : num  -0.469 -0.555 -0.514 -0.729 -0.59 ...
##  $ frequencybodyaccjerk-std-x       : num  -0.134 -0.314 -0.297 -0.297 -0.321 ...
##  $ frequencybodyaccjerk-std-y       : num  0.10674 -0.01533 -0.00561 -0.2099 -0.05452 ...
##  $ frequencybodyaccjerk-std-z       : num  -0.535 -0.616 -0.544 -0.772 -0.633 ...
##  $ frequencybodygyro-mean-x         : num  -0.339 -0.43 -0.438 -0.373 -0.373 ...
##  $ frequencybodygyro-mean-y         : num  -0.103 -0.555 -0.562 -0.688 -0.514 ...
##  $ frequencybodygyro-mean-z         : num  -0.256 -0.397 -0.418 -0.601 -0.213 ...
##  $ frequencybodygyro-std-x          : num  -0.517 -0.604 -0.615 -0.543 -0.529 ...
##  $ frequencybodygyro-std-y          : num  -0.0335 -0.533 -0.5689 -0.6547 -0.5027 ...
##  $ frequencybodygyro-std-z          : num  -0.437 -0.56 -0.546 -0.716 -0.42 ...
##  $ frequencybodyaccmag-mean         : num  -0.129 -0.324 -0.29 -0.451 -0.305 ...
##  $ frequencybodyaccmag-std          : num  -0.398 -0.577 -0.456 -0.651 -0.52 ...
##  $ frequencybodybodyaccjerkmag-mean : num  -0.0571 -0.1691 -0.1868 -0.3186 -0.2695 ...
##  $ frequencybodybodyaccjerkmag-std  : num  -0.1035 -0.1641 -0.0899 -0.3205 -0.3057 ...
##  $ frequencybodybodygyromag-mean    : num  -0.199 -0.531 -0.57 -0.609 -0.484 ...
##  $ frequencybodybodygyromag-std     : num  -0.321 -0.652 -0.633 -0.594 -0.59 ...
##  $ frequencybodybodygyrojerkmag-mean: num  -0.319 -0.583 -0.608 -0.724 -0.548 ...
##  $ frequencybodybodygyrojerkmag-std : num  -0.382 -0.558 -0.549 -0.758 -0.456 ...
```
### Sample of data

```r
head(avg_tidydata)
```

```
##   subject activity timebodyacc-mean-x timebodyacc-mean-y
## 1       1  walking          0.2773308        -0.01738382
## 2       2  walking          0.2764266        -0.01859492
## 3       3  walking          0.2755675        -0.01717678
## 4       4  walking          0.2785820        -0.01483995
## 5       5  walking          0.2778423        -0.01728503
## 6       6  walking          0.2836589        -0.01689542
##   timebodyacc-mean-z timebodyacc-std-x timebodyacc-std-y timebodyacc-std-z
## 1         -0.1111481        -0.2837403        0.11446134        -0.2600279
## 2         -0.1055004        -0.4236428       -0.07809125        -0.4252575
## 3         -0.1126749        -0.3603567       -0.06991407        -0.3874120
## 4         -0.1114031        -0.4408300       -0.07882674        -0.5862528
## 5         -0.1077418        -0.2940985        0.07674840        -0.4570214
## 6         -0.1103032        -0.2965387        0.16421388        -0.5043242
##   timegravityacc-mean-x timegravityacc-mean-y timegravityacc-mean-z
## 1             0.9352232           -0.28216502          -0.068102864
## 2             0.9130173           -0.34660709           0.084727087
## 3             0.9365067           -0.26198636          -0.138107866
## 4             0.9639997           -0.08585403           0.127764113
## 5             0.9726250           -0.10044029           0.002476236
## 6             0.9580675           -0.21469485           0.033188883
##   timegravityacc-std-x timegravityacc-std-y timegravityacc-std-z
## 1           -0.9766096           -0.9713060           -0.9477172
## 2           -0.9726932           -0.9721169           -0.9720728
## 3           -0.9777716           -0.9623556           -0.9520918
## 4           -0.9838265           -0.9679632           -0.9629681
## 5           -0.9793484           -0.9615855           -0.9645808
## 6           -0.9777799           -0.9642486           -0.9572050
##   timebodyaccjerk-mean-x timebodyaccjerk-mean-y timebodyaccjerk-mean-z
## 1             0.07404163            0.028272110          -4.168406e-03
## 2             0.06180807            0.018249268           7.895337e-03
## 3             0.08147459            0.010059149          -5.622646e-03
## 4             0.07835291            0.002956024          -7.676793e-04
## 5             0.08458888           -0.016319410           8.321594e-05
## 6             0.06995859           -0.016483172          -7.389312e-03
##   timebodyaccjerk-std-x timebodyaccjerk-std-y timebodyaccjerk-std-z
## 1            -0.1136156           0.067002501            -0.5026998
## 2            -0.2775305          -0.016602236            -0.5860904
## 3            -0.2686796          -0.044961959            -0.5294861
## 4            -0.2970426          -0.221165132            -0.7513914
## 5            -0.3028910          -0.091039743            -0.6128953
## 6            -0.1327848           0.008088974            -0.5757775
##   timebodygyro-mean-x timebodygyro-mean-y timebodygyro-mean-z
## 1         -0.04183096         -0.06953005          0.08494482
## 2         -0.05302582         -0.04823823          0.08283366
## 3         -0.02564052         -0.07791509          0.08134859
## 4         -0.03179826         -0.07269053          0.08056772
## 5         -0.04889199         -0.06901352          0.08154355
## 6         -0.02550962         -0.07444625          0.08388088
##   timebodygyro-std-x timebodygyro-std-y timebodygyro-std-z
## 1         -0.4735355        -0.05460777         -0.3442666
## 2         -0.5615503        -0.53845367         -0.4810855
## 3         -0.5718696        -0.56379326         -0.4766964
## 4         -0.5009167        -0.66539409         -0.6626082
## 5         -0.4908775        -0.50462203         -0.3187006
## 6         -0.4460210        -0.33170227         -0.3831393
##   timebodygyrojerk-mean-x timebodygyrojerk-mean-y timebodygyrojerk-mean-z
## 1             -0.08999754             -0.03984287             -0.04613093
## 2             -0.08188334             -0.05382994             -0.05149392
## 3             -0.09523982             -0.03878747             -0.05036161
## 4             -0.11532156             -0.03934745             -0.05511669
## 5             -0.08884084             -0.04495595             -0.04826796
## 6             -0.08788911             -0.03623090             -0.05395973
##   timebodygyrojerk-std-x timebodygyrojerk-std-y timebodygyrojerk-std-z
## 1             -0.2074219             -0.3044685             -0.4042555
## 2             -0.3895498             -0.6341404             -0.4354927
## 3             -0.3859230             -0.6390880             -0.5366641
## 4             -0.4923411             -0.8074199             -0.6404541
## 5             -0.3576814             -0.5714381             -0.1576825
## 6             -0.1826009             -0.4163902             -0.1666844
##   timebodyaccmag-mean timebodyaccmag-std timegravityaccmag-mean
## 1          -0.1369712         -0.2196886             -0.1369712
## 2          -0.2904076         -0.4225442             -0.2904076
## 3          -0.2546903         -0.3284289             -0.2546903
## 4          -0.3120506         -0.5276791             -0.3120506
## 5          -0.1583387         -0.3771787             -0.1583387
## 6          -0.1668407         -0.2667342             -0.1668407
##   timegravityaccmag-std timebodyaccjerkmag-mean timebodyaccjerkmag-std
## 1            -0.2196886              -0.1414288            -0.07447175
## 2            -0.4225442              -0.2814242            -0.16415099
## 3            -0.3284289              -0.2800093            -0.13991636
## 4            -0.5276791              -0.3667009            -0.31691896
## 5            -0.3771787              -0.2883330            -0.28224228
## 6            -0.2667342              -0.1951170            -0.07060296
##   timebodygyromag-mean timebodygyromag-std timebodygyrojerkmag-mean
## 1           -0.1609796          -0.1869784               -0.2987037
## 2           -0.4465491          -0.5530199               -0.5479120
## 3           -0.4664118          -0.5615107               -0.5661352
## 4           -0.4977922          -0.5531161               -0.6813040
## 5           -0.3559331          -0.4921768               -0.4445325
## 6           -0.2812078          -0.3656029               -0.3212905
##   timebodygyrojerkmag-std frequencybodyacc-mean-x frequencybodyacc-mean-y
## 1              -0.3253249              -0.2027943             0.089712726
## 2              -0.5577982              -0.3460482            -0.021904810
## 3              -0.5673716              -0.3166140            -0.081302435
## 4              -0.7301464              -0.4267194            -0.149399633
## 5              -0.4891997              -0.2877826             0.009460378
## 6              -0.3647083              -0.1879343             0.140781622
##   frequencybodyacc-mean-z frequencybodyacc-std-x frequencybodyacc-std-y
## 1              -0.3315601             -0.3191347             0.05604001
## 2              -0.4538064             -0.4576514            -0.16921969
## 3              -0.4123741             -0.3792768            -0.12403083
## 4              -0.6310055             -0.4472349            -0.10179945
## 5              -0.4902511             -0.2975174             0.04260268
## 6              -0.4985202             -0.3452277             0.10169964
##   frequencybodyacc-std-z frequencybodyaccjerk-mean-x
## 1             -0.2796868                  -0.1705470
## 2             -0.4552221                  -0.3046153
## 3             -0.4229985                  -0.3046944
## 4             -0.5941983                  -0.3588834
## 5             -0.4830600                  -0.3449548
## 6             -0.5504746                  -0.1509429
##   frequencybodyaccjerk-mean-y frequencybodyaccjerk-mean-z
## 1                 -0.03522552                  -0.4689992
## 2                 -0.07876408                  -0.5549567
## 3                 -0.14050859                  -0.5141373
## 4                 -0.27955339                  -0.7289916
## 5                 -0.18105555                  -0.5904966
## 6                 -0.07537423                  -0.5414386
##   frequencybodyaccjerk-std-x frequencybodyaccjerk-std-y
## 1                 -0.1335866                0.106739857
## 2                 -0.3143131               -0.015332952
## 3                 -0.2965966               -0.005614988
## 4                 -0.2973261               -0.209900006
## 5                 -0.3213903               -0.054521360
## 6                 -0.1926947                0.031445068
##   frequencybodyaccjerk-std-z frequencybodygyro-mean-x
## 1                 -0.5347134               -0.3390322
## 2                 -0.6158982               -0.4297135
## 3                 -0.5435291               -0.4378458
## 4                 -0.7723591               -0.3733845
## 5                 -0.6334300               -0.3726687
## 6                 -0.6086244               -0.2396507
##   frequencybodygyro-mean-y frequencybodygyro-mean-z
## 1               -0.1030594               -0.2559409
## 2               -0.5547721               -0.3966599
## 3               -0.5615263               -0.4181262
## 4               -0.6884601               -0.6013811
## 5               -0.5139517               -0.2131270
## 6               -0.3413784               -0.2035755
##   frequencybodygyro-std-x frequencybodygyro-std-y frequencybodygyro-std-z
## 1              -0.5166919             -0.03350816              -0.4365622
## 2              -0.6040530             -0.53304695              -0.5598566
## 3              -0.6151214             -0.56888867              -0.5458964
## 4              -0.5426468             -0.65465777              -0.7164585
## 5              -0.5293928             -0.50268338              -0.4203671
## 6              -0.5153239             -0.33200871              -0.5122092
##   frequencybodyaccmag-mean frequencybodyaccmag-std
## 1               -0.1286235              -0.3980326
## 2               -0.3242894              -0.5771052
## 3               -0.2900315              -0.4563731
## 4               -0.4508046              -0.6511726
## 5               -0.3049925              -0.5196369
## 6               -0.2013866              -0.4216831
##   frequencybodybodyaccjerkmag-mean frequencybodybodyaccjerkmag-std
## 1                      -0.05711940                     -0.10349240
## 2                      -0.16906435                     -0.16409197
## 3                      -0.18676452                     -0.08985199
## 4                      -0.31858781                     -0.32045870
## 5                      -0.26948166                     -0.30568538
## 6                      -0.05540142                     -0.09649997
##   frequencybodybodygyromag-mean frequencybodybodygyromag-std
## 1                    -0.1992526                   -0.3210180
## 2                    -0.5307048                   -0.6517928
## 3                    -0.5697558                   -0.6326433
## 4                    -0.6092856                   -0.5939372
## 5                    -0.4842628                   -0.5897415
## 6                    -0.3296811                   -0.5106483
##   frequencybodybodygyrojerkmag-mean frequencybodybodygyrojerkmag-std
## 1                        -0.3193086                       -0.3816019
## 2                        -0.5832493                       -0.5581046
## 3                        -0.6077516                       -0.5490870
## 4                        -0.7243274                       -0.7577681
## 5                        -0.5480536                       -0.4556653
## 6                        -0.3665005                       -0.4080789
```

### Following code writes average tidy data to a file "tidydata_average.txt"

```r
### write.table(avg_tidydata, 'tidydata_average.txt', row.names = F)
```
