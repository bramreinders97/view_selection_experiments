with

constr_results_and_pitstop_times as (

    select * from {{ ref('join_constructor_results_with_avg_pitstop_times') }}

),

qualy as (

    select * from {{ ref('stg_qualifying') }}

),

joined as (

    select
        cp.race_id,
        points,
        number,
        driver_id

    from constr_results_and_pitstop_times cp
    join qualy q
    on cp.race_id = q.race_id

)

    select * from joined