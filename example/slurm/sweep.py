{
    'params': {
        'nodes': [2, 4, 8, 16, 32],
        'test': ['sgd', 'k-means', 'terasort'],
        'reps': [10, 100]
    },

    'env': {
        'RESULTS_FOLDER': '$PWD/results',
        'CH_IMG': 'ivotron.openmpi:2.1.3',
    },

    'sbatch_args': {
        'partition': 'gpu',
    }
}
