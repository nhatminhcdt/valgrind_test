#!/bin/sh

BUILD_DIR="build"
CHECK_DIR="check"
COV_DIR="coverage"
# create folder to store the check result
mkdir -p $CHECK_DIR
mkdir -p $CHECK_DIR/$COV_DIR
# delete files in folder where coverage results are stored
rm -f ./$CHECK_DIR/*.*
rm -f ./$CHECK_DIR/$COV_DIR/*.*

# Set GCOV_PREFIX to the folder you want the output files to be in
export GCOV_PREFIX=$CHECK_DIR
path=`pwd`/$CHECK_DIR
# The sed command first separates any given string to multiple lines. Where each line contains a single character
# After that we can use grep command to search only for specific characters. In this case we print only character /
# What has left is to use wc -l to simply count the lines
slash_num=$(echo $path | sed -e 's/\(.\)/\1\n/g' | grep / | wc -l)
# GCOV_PREFIX_STRIP equal to the the number of forward slashes or “/” in the path.
export GCOV_PREFIX_STRIP=$slash_num
# run the test and check *.gcda file in data folder
eval $BUILD_DIR/prog.exe
#  Copy the .gcno file generated earlier to the data folder.
cd $CHECK_DIR
mv ../$BUILD_DIR/*.gcno .
# Use lcov to read the coverage output file generated by gcov
# -t    sets a test name
# -o    to specify the output file
# -c    to capture the coverage data
# -d    to specify the directory where the data files needs to be searched
lcov -t "result" -o cover.info -c -d .
# Generate out html output for the statistics
genhtml ./cover.info -o $COV_DIR

# Generate gprof information
cd ..
gprof ./$BUILD_DIR/prog.exe > ./$CHECK_DIR/gprof.log
