# floatcounter
A tool to get the sum of float numbers in a file.

## Introduction
This is a tool to calculate the total count of numbers and the sum of all numbers from a file.

## Usage
#### Build
It automatically builds when you run the tool for the first time. Make sure Maven is installed in your box.

#### Run
```
Usage: run_float_counter.sh \<input file\> [rebuild]
    input file - The file to be processed.
    rebuild - Force to rebuild the maven project if it is set to "rebuild".
        Otherwise use existing jar file if it exists.
```

## Sample input file
```
1.1 2.2 3.3 4.46
 1.1     2.2   3.3    4.46
1.0123456789
00 2.3 45 6.7890 0.1234567 7.6543210 
0.0000001 1.1111110 2.2222222 3.3333333 4.4444444 5.5555555 6.6666666 7.7777777 8.8888888 9.9999999
```
The files named "testfile*.txt" in folder "tests" are some sample input files for test.

## Contribution
Contributors to this project is welcome. This can involve any number of area.
- Documentation
- Core logic
- Wrapper script
- Unit Tests, well, any testing at all!

## Licensing
This project is licensed under the Mozilla Public License Version 2.0.
