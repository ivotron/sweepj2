#!/usr/bin/env bash
if [ {__nodes__} == 1 ]; then
  RUN_CMD='ch-run'
  TEST_NAME_SUFFIX='-baseline'
else
  RUN_CMD="mpirun -n {__nodes__} -N 1 ch-run"
  TEST_NAME_SUFFIX="-{__nodes__}"
fi

TEST_BIN={__test__}
TEST_ARGS="--iterations 100 --repetitions {__reps__}"
case {__test__} in
  'sgd')
    TEST_ARGS+=' --points 2500000'
    ;;
  'k-means')
    TEST_ARGS+=' --clusters 5'
    TEST_ARGS+=' --size 10000000'
    ;;
  'terasort')
    TEST_ARGS+=' --keys 1000000'
    ;;
  *)
    echo "Unknown test '{__test__}'"
    exit 1
    ;;
esac

mkdir -p $PWD/results/{__test__}

$RUN_CMD $TEST_BIN $TEST_ARGS --output $PWD/results/$test
