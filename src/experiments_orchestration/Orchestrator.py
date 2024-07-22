"""Orchestrator class"""
from Experiment import Experiment
from vars_to_set import N_RUNS, COMBINATIONS  # ALL_DAGS, LIMIT_FRACTIONS, N_RUNS


def run_all_experiments():

    # total_number_of_runs = 2 * len(ALL_DAGS) * len(LIMIT_FRACTIONS) * N_RUNS
    total_number_of_runs = 2 * len(COMBINATIONS) * N_RUNS
    i = 0

    for _ in range(N_RUNS):
        for combi in COMBINATIONS:
            dag = combi['dag']
            limit = combi['lf']
        # for dag in ALL_DAGS:
        #     for limit in LIMIT_FRACTIONS:
            experiment = Experiment(
                dag=dag,
                limit_fraction=limit
            )

            i += 1

            print(f"""
            Starting run:
            n_th run: {i} / {total_number_of_runs}
            DAG: {dag}
            LIMITS FRACTION: {limit}
            MATERIALIZATION: False
            """)

            experiment.do_run_without_materialization()

            i += 1

            print()
            print(f"""
            Starting run:
            n_th run: {i} / {total_number_of_runs}
            DAG: {dag}
            LIMITS FRACTION: {limit}
            MATERIALIZATION: True
            """)

            experiment.do_run_with_materialization()


run_all_experiments()
