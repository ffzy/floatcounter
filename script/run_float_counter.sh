#!/bin/bash

file=$1
rebuild=$2

function usage {
    cat << EOF
Float Counter, a tool to calculate the total count of numbers and the sum of all numbers from a file.
Usage: $(basename $0) <input file> [rebuild]
    input file - The file to be processed.
    rebuild - Force to rebuild the maven project if it is set to "rebuild".
        Otherwise use existing jar file if it exists.
EOF
}

function build {
    echo -n "Building... "
    echo > $mvn_log
    cd $fp_home
    mvn package > $mvn_log || {
        echo "Build failed. Please check $mvn_log for the problem."
        cd -
        return 1
    }
    cd -
    echo "Done."
}

function run {
    echo "Running... "
    java -jar -DfileName="$file" $jar_file
    typeset rc=$?
    echo "Done."
    return $rc
}

[[ -z $file ]] && {
    usage
    exit 1
}

dirname=$(dirname $0)
fp_home=${dirname}/..
mvn_log=/tmp/mvn_build.log

ls $fp_home/target/floatcounter-*-jar-with-dependencies.jar > /dev/null 2>&1 \
    || rebuild="rebuild"

if [[ $rebuild == "rebuild" ]]; then
    build || exit 1

    build_info=$(grep Building $mvn_log | head -1) 
    jar_file_name="$(echo $build_info | cut -d: -f2)-$(echo $build_info \
        | cut -d: -f4)-jar-with-dependencies.jar"
    jar_file=$fp_home/target/$jar_file_name
    echo "Jar file: $jar_file"
else
    jar_files=$(ls $fp_home/target/floatcounter-*-jar-with-dependencies.jar)
    if [[ -z $jar_files ]]; then
        echo "Error: No jar file found." \
            "Please enable the \"rebuild\" option and run again."
        exit 1
    fi

    echo "Jar file(s) found: $jar_files."
    jar_file=$(echo "$jar_files" | tail -1)
    echo "Use the latest version - $jar_file)"
fi

run
exit $?
