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

[[ -z $file ]] && {
    usage
    exit 1
}

dirname=$(dirname $0)
fp_home=${dirname}/..

ls $fp_home/target/*-jar-with-dependencies.jar > /dev/null 2>&1 || rebuild="rebuild"

if [[ $rebuild == "rebuild" ]]; then
    echo -n "Building... "
    mvn_log=/tmp/mvn_build.log
    echo > $mvn_log
    cd $fp_home
    mvn package > $mvn_log
    cd -
    echo "Done."

    build_info=$(grep Building $mvn_log | head -1) 
    jar_file_name="$(echo $build_info | cut -d: -f2)-$(echo $build_info | cut -d: -f4)-jar-with-dependencies.jar"
    jar_file=$fp_home/target/$jar_file_name
else
    jar_file=$(ls $fp_home/target/*-jar-with-dependencies.jar)
fi

echo "Jar file: $jar_file"

ls $jar_file > /dev/null || {
    echo "Error: No jar file found."
    exit 1
}

echo "Running... "
java -jar -DfileName="$file" $jar_file
echo "Done."
