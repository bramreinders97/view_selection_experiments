"""Class that deals with dbt_project.yml."""

import ruamel.yaml
from ruamel.yaml.comments import CommentedMap
from ast import literal_eval
from math import ceil
from typing import List


class DbtProjectHandler:
    """TODO
    """

    def __init__(
        self,
        filepath: str
    ):
        """Initialize YamlScraper class, and run checks on contents."""
        self.filepath = filepath
        self.contents = self._read_contents()

    def _read_contents(self) -> CommentedMap:
        """Read the contents of a yaml file."""
        yaml = ruamel.yaml.YAML()
        with open(self.filepath, "r") as f:
            data = yaml.load(f)
        return data

    def _write_contents(self):
        """Write the modified contents back to the yaml file."""
        yaml = ruamel.yaml.YAML()
        yaml.indent(mapping=2, sequence=4, offset=2)
        with open(self.filepath, "w") as f:
            yaml.dump(self.contents, f)

    def _extract_name(self) -> str:
        """Extract the name property."""
        return self.contents['name']

    def _extract_model_info(self) -> CommentedMap:
        """Extract all information regarding the models in the DAG."""
        return self.contents['models']

    def get_all_models(self) -> List[str]:
        """Used for fudge factor experiment 2.0"""
        project_name = self._extract_name()
        models = self._extract_model_info()
        list_including_marts = list(models[project_name].keys())
        return [model for model in list_including_marts if model != 'marts']

    def set_all_intermediates_to_view(self):
        """Set the +materialized property of all intermediate models to 'view'."""
        project_name = self._extract_name()
        models = self._extract_model_info()

        for model_name, properties in models[project_name].items():
            if isinstance(properties, CommentedMap) and model_name != 'marts':
                properties["+materialized"] = "view"

        self._write_contents()

    def _set_model_to_table(self, model: str):
        """Set the +materialized property of the specified model to 'table'."""
        project_name = self._extract_name()
        models = self._extract_model_info()

        properties = models[project_name][model]
        if isinstance(properties, CommentedMap):
            properties["+materialized"] = "table"

        self._write_contents()

    def implement_advise(self, models_to_materialize: str):
        # Not the prettiest but for now it suffices
        if models_to_materialize == '':
            return
        tuple_ = literal_eval(models_to_materialize)
        if tuple_ is None:
            return
        for full_model_id in tuple_:
            model_name = full_model_id.split('.')[-1]
            self._set_model_to_table(model_name)

    def _get_total_sizes(self) -> CommentedMap:
        """Return the total sizes of the source tables as described in dbt_project.yml."""
        return self.contents['vars']['total_stg_table_sizes']

    def get_current_limits(self) -> CommentedMap:
        """Return the limits imposed on the src tables in the DAGs"""
        return self.contents['vars']['limit_used_in_experiment']

    def change_table_limits(self, fraction: float):
        """Set the limit variables to `fraction` * `total_size_src_table`, with a minimum of 100."""
        limits = self.contents['vars']['limit_used_in_experiment']

        for table, total_size_src_table in self._get_total_sizes().items():
            limits[table] = max(ceil(fraction * total_size_src_table), 100)

        self._write_contents()

    def get_name(self) -> str:
        """Return the name of the DAG, as specified in dbt_project.yml"""
        return self._extract_name()
