with

all_positions as (

    select * from {{ ref('join_lap_times_pit_stops') }}

),

drivers as (

    select * from {{ ref('stg_drivers') }}

),

only_worse_than_10th as (

    select
        drivers.driver_id,
        position,
        driver_ref

    from all_positions
    join drivers
    on all_positions.driver_id = drivers.driver_id

    where position > 10

)

    select * from only_worse_than_10th