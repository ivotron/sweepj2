#!/usr/bin/env bash
set -ex

#export PATH=$PATH:$PWD/../

function check_output {
    test -d $1
    test $(ls -l $1 | wc -l) -eq 31
    cat $1/output_001-* | grep "\-N 1"
#    cat $1/output_010-* | grep "$2/job_010_.*\.out"
#    cat $1/output_030-* | grep "RESULTS_FOLDER=$PWD/results"
}

# test default

rm -rf ./new/output/

./new/demo

check_output ./new/output

# test custom path
rm -rf /tmp/test/
mkdir -p /tmp/test/
cp ./new/test/script.sh /tmp/test
cp ./new/test/config.yml /tmp/test

./new/demo \
  --template /tmp/test/script.sh \
  --space /tmp/test/config.yml

check_output ./new/output

