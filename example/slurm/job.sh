if [ $nodes == 1 ]; then
  RUN_CMD='ch-run'
  TEST_NAME_SUFFIX='-baseline'
else
  RUN_CMD="mpirun -n $nodes -N 1 ch-run"
  TEST_NAME_SUFFIX="-$nodes"
fi

TEST_BIN=$test
TEST_ARGS="--iterations 100 --repetitions $reps"
case $test in
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
    echo "Unknown test '$test'"
    exit 1
    ;;
esac

mkdir -p $RESULTS_FOLDER/$test

$RUN_CMD $TEST_BIN $TEST_ARGS --output $RESULTS_FOLDER/$test
