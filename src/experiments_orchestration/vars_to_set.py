""" VARS TO SET """
N_RUNS = 6000

N_RUNS_FUDGE_FACTOR = 1000

# ALL_DAGS = [
#     # 'My_Own_000',
#     'My_Own_001',
#     # 'My_Own_010',
#     # 'My_Own_011',
#     # 'My_Own_100',
#     # 'My_Own_101',
#     # 'My_Own_110',
#     # 'My_Own_111',
#     # 'Toy_Example_Cost_Calculation'
# ]

# ALL_DAGS = [
#     'F1_Data_Pipeline',
#     'Glue_AWS',
#     'Transfermarkt_altered',
# ]

# LIMIT_FRACTIONS = [
#     1,
#     # 0.5,
#     # 0.05,
#     # 0.005,
#     0.0005,
# ]


COMBINATIONS = [
    # {
    #     'dag': 'My_Own_001',
    #     'lf': 0.0005
    # },
    {
        'dag': 'My_Own_001',
        'lf': 1
    },
    # {
    #     'dag': 'My_Own_010',
    #     'lf': 0.0005
    # },
    # {
    #     'dag': 'My_Own_010',
    #     'lf': 0.5
    # },
    # {
    #     'dag': 'My_Own_100',
    #     'lf': 1
    # },
    # {
    #     'dag': 'My_Own_101',
    #     'lf': 0.005
    # },
    {
        'dag': 'My_Own_101',
        'lf': 0.5
    },
    {
        'dag': 'My_Own_111',
        'lf': 0.005
    },
    {
        'dag': 'My_Own_111',
        'lf': 0.05
    }
]

FOLDER_CONTAINING_DAGS = (r'C:\Users\bramr\OneDrive\Documenten\Blenddata\Initiële uitwerkingen opdrachten\DBT\Dataset '
                          r'Creation\DAG investigations\DAG_investigator\model_folders')

VST_ADVISE_PATH = (r'C:/Users/bramr/OneDrive/Documenten/Blenddata/Initiële uitwerkingen '
                   r'opdrachten/DBT/Code/Tool_Python/src/view_selection_python/main.py')

EXPERIMENT_DB_YML_PATH = (r'C:\Users\bramr\OneDrive\Documenten\Blenddata\Initiële uitwerkingen '
                          r'opdrachten\DBT\Code\Experiments\experiments_db.yml')

ALTERED_VST_PATH = (r'C:\Users\bramr\OneDrive\Documenten\Blenddata\Initiële uitwerkingen '
                    r'opdrachten\DBT\Code\Experiments\src\fudge_factor_experiments\altered_vst_code\main.py')

ALTERED_VST_COST_DICT_PATH = (r'C:\Users\bramr\OneDrive\Documenten\Blenddata\Initiële uitwerkingen '
                               r'opdrachten\DBT\Code\Experiments\src\fudge_factor_experiments\altered_vst_code'
                               r'\dump_model_costs_dict.py')
