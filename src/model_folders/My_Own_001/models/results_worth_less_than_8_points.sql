with

all_results as (

    select * from {{ ref('join_constructor_results_with_avg_pitstop_times') }}

),

results_worth_less_than_8_points as (

    select
        race_id,
        points,
        constructor_id

    from all_results
    where points < 8

)

    select * from results_worth_less_than_8_points