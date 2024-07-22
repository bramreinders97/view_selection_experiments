-- Create the 'VstAdvise' table
CREATE TABLE experiments.public.vst_advise (
    advice_id SERIAL PRIMARY KEY,
    advice_output TEXT,
    dag TEXT,
    limit_fraction DOUBLE PRECISION,
    experiment_setup TEXT
);

-- Create the 'DBTRuns' table
CREATE TABLE experiments.public.dbt_runs (
    invocation_id TEXT PRIMARY KEY,
    limit_fraction DOUBLE PRECISION,
    limit_vars TEXT,
    DAG TEXT,
    total_runtime DOUBLE PRECISION,
    logs TEXT,
    type TEXT,
    experiment_setup TEXT
);

-- Create the 'Timeline' table
CREATE TABLE experiments.public.timeline (
    timeline_id SERIAL PRIMARY KEY,
    type TEXT,
    advice_id INTEGER,
    invocation_id TEXT,
    run_at TIMESTAMP
);
