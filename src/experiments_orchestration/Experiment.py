import os
from src.experiments_orchestration.DbtProjectHandler import DbtProjectHandler
from src.experiments_orchestration.PythonHandler import PythonHandler
from src.experiments_orchestration.PostgresHandler import PostgresHandler
from src.experiments_orchestration.YAMLReader import YAMLReader
from src.experiments_orchestration.vars_to_set import FOLDER_CONTAINING_DAGS, EXPERIMENT_DB_YML_PATH
from typing import Tuple


class Experiment:
    def __init__(self, dag, limit_fraction):
        self.dag_name = dag
        self.limit_fraction = limit_fraction

        # Initialize relevant handlers
        # Deals with dbt_project.yml
        self.dbt_project_handler = DbtProjectHandler(
            filepath=self._get_dbt_project_path()
        )

        # Deals with profiles.yml, which is where we store the db creds
        # of the DB where the to be investigated DAG stores its data
        self.profiles_handler = YAMLReader(
            filepath=self._get_profiles_path()
        )

        # Deals with experiments_db.yml, which contains the db creds
        # for the DB where we store the results of the experiments
        self.exp_db_yml = YAMLReader(
            filepath=EXPERIMENT_DB_YML_PATH,
            profile_name_key="experiments",
            outputs_key="credentials"
        )

        # Talks to the DB where the to be investigated DAG stores its data
        self.dbt_postgres_handler = PostgresHandler(
            db_creds=self.profiles_handler.extract_db_creds()
        )

        # Talks to the DB where we store the results of the experiments
        self.experiments_postgres = PostgresHandler(
            db_creds=self.exp_db_yml.extract_db_creds()
        )

        # Runs Python code for us
        self.python_handler = PythonHandler(
            dag_name=self.dbt_project_handler.get_name()
        )

    def _get_root_folder_dag(self) -> str:
        """Return the location of the root folder of this dbt project."""
        return os.path.join(FOLDER_CONTAINING_DAGS, self.dag_name)

    def _get_dbt_project_path(self) -> str:
        """Return the path of the dbt_project.yml file for this experiment."""
        return os.path.join(FOLDER_CONTAINING_DAGS, self.dag_name, 'dbt_project.yml')

    def _get_profiles_path(self) -> str:
        """Return the path of the profiles.yml file for this experiment."""
        return os.path.join(FOLDER_CONTAINING_DAGS, self.dag_name, 'profiles.yml')

    def _set_table_limits(self):
        """Set the limits of the source tables for this experiment."""
        self.dbt_project_handler.change_table_limits(
            fraction=self.limit_fraction
        )

    def _store_run_info(self, with_materialization: bool, log_output: str):
        """Store all relevant info regarding a `dbt run`."""
        # Get invocation_id of run
        (last_invocation_id, total_runtime) = self.dbt_postgres_handler.get_last_invocation_id()

        # Store all relevant info
        self.experiments_postgres.store_run_info(
            invocation_id=last_invocation_id,
            limit_fraction=self.limit_fraction,
            limit_vars=str(self.dbt_project_handler.get_current_limits()),
            dag=self.dag_name,
            total_runtime=total_runtime,
            logs=log_output,
            with_materialization=with_materialization
        )

        self.experiments_postgres.store_timeline_info(
            invocation_id=last_invocation_id
        )

    def do_run_without_materialization(self):
        """Run the DAG without materialization of intermediate nodes, store results"""
        self._set_table_limits()

        # Make sure we'll store everything as a view
        self.dbt_project_handler.set_all_intermediates_to_view()

        # Do the run
        dbt_log_output = self.python_handler.do_dbt_run(
            working_dir=self._get_root_folder_dag()
        )

        # Store relevant info
        self._store_run_info(
            with_materialization=False,
            log_output=dbt_log_output
        )

    def _store_advice(self, advice: str):
        """Store the obtained advice on materialization"""
        advice_id = self.experiments_postgres.store_advice_info(
            advice=advice,
            dag=self.dag_name,
            limit_fraction=self.limit_fraction
        )

        self.experiments_postgres.store_timeline_info(
            advice_id=advice_id
        )

    def _get_advice_on_materialization(self) -> str:
        """Return the advice given by vst."""
        advice = self.python_handler.get_advice(
            working_dir=self._get_root_folder_dag()
        )
        return advice

    def do_run_with_materialization(self):
        """Run the DAG with materialization of intermediate nodes, store results"""
        # Set table limits to be sure
        self._set_table_limits()

        # Get advice on materialization
        advice = self._get_advice_on_materialization()

        # NOte that returning NONE is also possible
        # If the advice is to materialize, store this, and change dbt_project.yml accordingly
        if advice is not None:
            # Store the advice for documentations' sake
            self._store_advice(advice=advice)

            # Implement the advice
            self.dbt_project_handler.implement_advise(
                models_to_materialize=advice
            )

        # If the Advice is not to materialiaze, store that accordingly
        else:
            self._store_advice('No Materialization')

        # Do run with new materialization settings
        dbt_log_output = self.python_handler.do_dbt_run(
            working_dir=self._get_root_folder_dag()
        )

        # Store relevant info
        self._store_run_info(
            with_materialization=True,
            log_output=dbt_log_output
        )

    def do_run_with_materialization_fudge_factor_experiment(self, config: Tuple[str]):
        """Made especially for fudge factor experiment"""
        # Set table limits to be sure
        self._set_table_limits()

        # Implement the conifg
        self.dbt_project_handler.implement_advise(
            models_to_materialize=f'{config}'
        )

        # Do run with new materialization settings
        _ = self.python_handler.do_dbt_run(
            working_dir=self._get_root_folder_dag()
        )
