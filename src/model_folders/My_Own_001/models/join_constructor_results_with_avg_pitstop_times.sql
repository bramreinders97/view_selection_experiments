with

constructor_results as (

    select * from {{ ref('all_constructor_results') }}

),

avg_pit_stop_times as (

    select * from {{ ref('avg_pit_stop_time_per_race_id') }}

),

joined as (

    select
        c.race_id,
        avg_ms,
        constructor_id,
        points

    from constructor_results c
    join avg_pit_stop_times a
    on c.race_id = a.race_id

)

    select * from joined