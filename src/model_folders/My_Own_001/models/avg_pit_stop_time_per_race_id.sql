with

pit_stops as (

    select * from {{ ref('stg_pit_stops') }}

),

avg_pit_stop_time_per_race as (

    select
        race_id,
        avg(ms) as avg_ms

    from pit_stops
    group by race_id

)

    select * from avg_pit_stop_time_per_race