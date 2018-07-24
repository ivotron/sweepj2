#!/usr/bin/env bash
set -ex

export PATH=$PATH:$PWD/../

function check_output {
    test -d $1
    test $(ls -l $1 | wc -l) -eq 31
    cat $1/job_1 | grep "\-N 2"
    cat $1/job_*_10 | grep "$2/job_*_10.out"
    cat $1/job_*_30 | grep "RESULTS_FOLDER=$PWD/results"
}

# test default
pushd ../example

rm -rf slurm/jobs slurm/logs

slurmp --generate

check_output slurm/jobs slurm/logs
popd

# test custom path
rm -rf /tmp/test/
mkdir -p /tmp/test/
cp ../example/slurm/job.sh /tmp/test
cp ../example/slurm/sweep.py /tmp/config.py

pushd /tmp/test

slurmp --generate \
  --job-dir slurm-jobs \
  --logs-dir job-logs \
  --job-file ./job.sh \
  --config /tmp/config.py

check_output slurm-jobs
popd
