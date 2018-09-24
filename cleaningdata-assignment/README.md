# This is the README file for the Coursera "Getting and Cleaning Data" course peer assignment

This folder contains the following files:

run_analysis.R: this contains a function run_analysis which when run will return the tidy data set
required by the course assignment.    It assumes the presence of the files in the current directory
and subdirectories as detail in README.txt (the relevant files are present in this repository - however
it does not include the Inertial Signals
data as it was felt that the files in those folders were not needed as it had already been summarised.

To get the data you load and run the run_analysis.R script.   Then you can load the data as follows:

summary_data <- run_analysis()

README.txt is the file that comes with the data set.    As mentioned above it describes the data files
contained in this folder.

CodeBook.md was not explicitly referenced as a requirement in the end, so I've not created one.
