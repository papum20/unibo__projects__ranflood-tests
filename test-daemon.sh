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


# test number
N=$(date +'%Y%m%d-%H_%M_%S')

test_file="test_n.txt"

echo $N > $test_file


rm ranflood ranfloodd filechecker
ln -s ../ranflood-my/build/libs/filechecker.jar filechecker
ln -s ../ranflood-my/build/libs/ranflood.jar ranflood
ln -s ../ranflood-my/build/libs/ranfloodd.jar ranfloodd


cp -r build-compare/ build-compare-${N}/

$path_java21 -jar ./ranfloodd ./settings.ini