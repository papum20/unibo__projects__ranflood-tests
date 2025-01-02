#!/bin/bash


test_file="test_n.txt"

#read N
N=$(cat $test_file)

dirname="checker-on-the-fly-$N"
mkdir $dirname


java -jar ./filechecker save $dirname/checksum-$N.json build-compare-$N

java -jar ./filechecker check \
	$dirname/checksum-$N.json $dirname/report-$N.json build-compare-$N \
	> "$dirname/log-$N.txt"
