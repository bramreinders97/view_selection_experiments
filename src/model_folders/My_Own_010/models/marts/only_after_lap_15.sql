with

all_laps as (

    select * from {{ ref('join_lap_times_pit_stops') }}

),

drivers as (

    select * from {{ ref('stg_drivers') }}

),

only_after_lap_15 as (

    select
        drivers.driver_id,
        lap_ms,
        driver_ref

    from all_laps
    join drivers
    on all_laps.driver_id = drivers.driver_id

    where lap > 15

)

    select * from only_after_lap_15