#!/bin/bash

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


./ranflood.sh snapshot take sss-ransomware build-compare-$N
sleep 1
./ranflood.sh flood start sss-ransomware build-compare-$N
