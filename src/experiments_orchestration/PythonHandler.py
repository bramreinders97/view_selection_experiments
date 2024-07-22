"""Class that runs python scripts."""
import json
import os
import subprocess
from typing import Dict

from src.experiments_orchestration.vars_to_set import VST_ADVISE_PATH, ALTERED_VST_PATH, FOLDER_CONTAINING_DAGS, ALTERED_VST_COST_DICT_PATH


def find_exe(which: str):
    # Start in the current directory
    current_dir = os.getcwd()

    # Traverse up the directory hierarchy
    while True:
        # Construct the path to check
        target_path = os.path.join(current_dir, '.venv', 'Scripts', f'{which}.exe')

        # Check if the file exists at this path
        if os.path.isfile(target_path):
            return target_path  # Return the path if the file is found

        # Move up one directory level
        parent_dir = os.path.dirname(current_dir)

        # If the parent directory is the same as the current, we've reached the root
        if parent_dir == current_dir:
            return None  # File not found
        current_dir = parent_dir


class PythonHandler:
    def __init__(self, dag_name: str):
        self.dbt_exe = find_exe('dbt')
        self.python_exe = find_exe('python')
        self.dag_name = dag_name

    def _call_dbt_run_exclude(self, working_dir: str) -> str:
        """Call `dbt run --full-refresh --exclude view_selection_tool`."""
        dbt_command = [self.dbt_exe, "run", "--full-refresh", "--select", f"{self.dag_name}"]
        output = subprocess.run(dbt_command, cwd=working_dir, text=True, capture_output=True).stdout
        return output

    def _call_dbt_run_select(self, working_dir: str):
        """Call `dbt run --select view_selection_tool`."""
        dbt_command = [self.dbt_exe, "run", "--full-refresh", "--select", "view_selection_tool"]
        subprocess.run(dbt_command, cwd=working_dir, text=True)

    def do_dbt_run(self, working_dir: str) -> str:
        """Call both dbt run commands for the current experiment."""
        dbt_run_exclude_output = self._call_dbt_run_exclude(working_dir)
        self._call_dbt_run_select(working_dir)
        return dbt_run_exclude_output

    def _extract_parentheses_content(self, s: str) -> str:
        start = s.find('(')
        end = s.find(')', start)
        if start != -1 and end != -1:
            return s[start:end + 1]
        else:
            return None  # or you can return an empty string, or any other value indicating not found

    def get_advice(self, working_dir: str) -> str | None:
        vst_main_file = VST_ADVISE_PATH
        command = [self.python_exe, vst_main_file]
        # advise = subprocess.run(command, cwd=working_dir, text=True, capture_output=True).stdout
        advise = subprocess.run(command, cwd=working_dir, text=True, capture_output=True).stdout.strip()
        advise = self._extract_parentheses_content(advise)
        return advise

    def get_model_info_dict(self) -> Dict:
        """Used for Fudge Factor Experiments 2.0"""
        altered_vst_main_file = ALTERED_VST_PATH
        wd = os.path.join(FOLDER_CONTAINING_DAGS, self.dag_name)
        result = subprocess.run([self.python_exe, altered_vst_main_file], cwd=wd, capture_output=True, text=True)
        print(result.stderr)
        output = result.stdout.strip()
        model_info_dict = json.loads(output)
        return model_info_dict

    def get_cost_dict(self) -> Dict:
        """Used for fudge calculation Experiments 2.0"""
        altered_vst_cost_file = ALTERED_VST_COST_DICT_PATH
        wd = os.path.join(FOLDER_CONTAINING_DAGS, self.dag_name)
        result = subprocess.run([self.python_exe, altered_vst_cost_file], cwd=wd, capture_output=True, text=True)
        output = result.stdout.strip()
        model_info_dict = json.loads(output)
        return model_info_dict