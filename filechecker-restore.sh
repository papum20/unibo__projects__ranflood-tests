#!/bin/bash


test_file="test_n.txt"

#read N
N=$(cat $test_file)

dirname="checker-$N"
mkdir $dirname


java -jar ./filechecker save $dirname/checksum-$N.json build-compare-$N

java -jar ./filechecker restore --delete --debug -l="$dirname/log-$N.txt" \
	$dirname/checksum-$N.json $dirname/report-$N.json build-compare-$N
