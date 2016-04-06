#!/bin/bash

file=${1?"Input file required."}

dirname=$(dirname $0)
fp_home=${dirname}/..

echo -n "Building... "
mvn_log=/tmp/mvn_build.log
echo > $mvn_log
cd $fp_home
mvn package > $mvn_log
cd -
echo "Done."

build_info=$(grep Building $mvn_log | head -1) 
jar_file_name="$(echo $build_info | cut -d: -f2)-$(echo $build_info | cut -d: -f4)-jar-with-dependencies.jar"
echo "Jar file: $jar_file_name"

ls $fp_home/target/$jar_file_name > /dev/null || {
    echo "Error: No jar file found."
    exit 1
}

echo "Running... "
java -jar -DfileName="$file" $fp_home/target/$jar_file_name
echo "Done."
