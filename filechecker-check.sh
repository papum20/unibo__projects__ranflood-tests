#!/bin/bash


test_file="test_n.txt"

usage() {
	echo "Usage: $0 [N]"
	echo "	N: test number. If not provided, read from $test_file"
	exit 1
}


if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	usage
elif [ -z "$1" ]; then
	if [ ! -f "$test_file" ]; then
		echo "Error: $test_file not found"
		usage
	else
		#read N
		N=$(cat $test_file)
	fi
else
	N="$1"
fi


dirname="checker-on-the-fly-$N"
mkdir $dirname


java -jar ./filechecker save $dirname/checksum-$N.json build-compare-$N

java -jar ./filechecker check \
	$dirname/checksum-$N.json $dirname/report-$N.json build-compare-$N \
	> "$dirname/log-$N.txt"
