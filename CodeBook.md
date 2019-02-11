# Code book for Coursera *Getting and Cleaning Data  Week 4* course project.

Code book explains `tidy_data_set.txt` from the current repository.

`README.md` enlists/explans steps performed to create this data set.

The structure data set is described in the [Data Set](#data) section, variables are listed in the [Variables](#variables) section, and transformations that were carried out to obtain the data set based on the source data are presented in the [Transformations](#transformations) section.

## Data Set <a name="dataSet"></a>

The `tidy_data_set.txt` data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the [Variables](#variables) section, and the following rows contain the values of these variables. 

## Variables <a name="variables"></a>

Each row has averaged signal measurements for every subject.

### Identifiers <a name="identifiers"></a>

- 'subject'

	Subject identifier, integer, ranges from 1 to 30.

- 'activity'

	Activity identifier, string with 6 possible values: 
	- 'WALKING': subject was walking
	- 'WALKING_UPSTAIRS': subject was walking upstairs
	- 'WALKING_DOWNSTAIRS': subject was walking downstairs
	- 'SITTING': subject was sitting
	- 'STANDING': subject was standing
	- 'LAYING': subject was laying

### Average of measurements <a name="average-measurements"></a>

All measurements are floating-point values, normalised and bounded within [-1,1].

The measurements are classified in two domains:

- Time-domain signals (variables prefixed by 'timeDomain'), resulting from the capture of accelerometer and gyroscope raw signals.

- Frequency-domain signals (variables prefixed by 'frequencyDomain'), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals.

## Transformations <a name="transformations"></a>

The SOURCE data set is located at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The following transformations were applied to the source data:

1. The training and test sets were merged to create one data set.
1. The measurements on the mean and standard deviation (i.e. signals containing the strings 'mean' and 'std') were extracted for each measurement, and the others were discarded.
1. The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see [Identifiers](#identifiers) section).
1. The variable names were replaced with descriptive variable names (e.g. 'tBodyAcc-mean()-X' was expanded to 'timeDomainBodyAccelerometerMeanX'), using the following set of rules:
	- Special characters (i.e. '(', ')', and '-') were removed
	- The initial 'f' and 't' were expanded to 'frequencyDomain' and 'timeDomain' respectively.
	- 'Acc', 'Gyro', 'Mag', 'Freq', 'mean', and 'std' were replaced with 'Accelerometer', 'Gyroscope', 'Magnitude', 'Frequency', 'Mean', and 'StandardDeviation' respectively.
1. From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.

The collection of the source data and the transformations listed above were implemented by the 'run_analysis.R' R script (see 'README.md' file for usage instructions).