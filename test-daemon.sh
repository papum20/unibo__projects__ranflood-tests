#!/bin/bash

path_java17_home=/usr/lib/jvm/java-17-openjdk-amd64/
path_java17=${path_java17_home}/bin/java
path_java21_home=/usr/lib/jvm/java-21-openjdk-amd64/
path_java21=${path_java21_home}/bin/java

# build
cd ../ranflood-my
rm build/libs/*
./gradlew -Dorg.gradle.java.home="${path_java21_home}" build && \
	./gradlew -Dorg.gradle.java.home="${path_java21_home}" jar filecheckerJar
cd ../ranflood-test


usage() {
	echo "Usage: $0 [N]"
	echo "	N: test number. If not provided, generated."
	exit 1
}


if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	usage
elif [ -z "$1" ]; then
	if [ ! -f "$test_file" ]; then
		echo "Error: $test_file not found"
		usage
	else
		# test number
		N=$(date +'%Y%m%d-%H_%M_%S')
	fi
else
	N="$1"
fi


test_file="test_n.txt"

echo $N > $test_file


rm ranflood ranfloodd filechecker
ln -s ../ranflood-my/build/libs/filechecker.jar filechecker
ln -s ../ranflood-my/build/libs/ranflood.jar ranflood
ln -s ../ranflood-my/build/libs/ranfloodd.jar ranfloodd


cp -r build-compare/ build-compare-${N}/

$path_java21 -jar ./ranfloodd ./settings.ini