## Welcome
Hello, welcome to this repository! The code in this repo is used to run the experiments for my thesis on the View Selection Problem in dbt (Data Build Tool).

_link to thesis once it's online_

## How to Use
If you want to run experiments on dbt projects as explained in the Experiments chapter of my thesis, follow these steps:

1. Create a database where you would like to store the results.
2. Create the relevant tables in this database using the commands provided in `create_experiments_related_tables.sql`.
3. Specify the database credentials of the newly created table in `experiments_db.yml`.
4. Fill in the full path of `experiments_db.yml` in the `EXPERIMENT_DB_YML_PATH` variable in `vars_to_set.py`.

5. Ensure all dbt projects are in a single folder (e.g., `src/model_folders`).
6. Fill in the full path of this folder in the `FOLDER_CONTAINING_DAGS` variable in `vars_to_set.py`.

7. Make sure you know the full path to the `src/view_selection_python/main.py` file from [the python part of ViewSelectionAdvisor](https://github.com/bramreinders97/view_selection_tool_python).
8. Fill in this path in the `VST_ADVISE_PATH` variable in `vars_to_set.py`.

9. Fill in all combinations of limit fractions and workloads you want to run tests for in the `COMBINATIONS` variable in `vars_to_set.py`.
10. Specify the number of runs you want to do in the `N_RUNS` variable in `vars_to_set.py`.

11. Simply run `Orchestrator.py` and the experiments will execute, storing the results in the created database.
