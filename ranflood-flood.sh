#!/bin/bash

# read n
N=$(cat test_n.txt)


./ranflood.sh snapshot take on-the-fly build-compare-$N
sleep 1
./ranflood.sh flood start on-the-fly build-compare-$N
