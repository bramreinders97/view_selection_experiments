with

all_laps as (

    select * from {{ ref('laps_joined_with_drivers') }}

),

only_first_30_laps_of_race as (

    select
        race_id,
        position,
        driver_id,
        lap

    from all_laps
    where lap < 30

)

    select * from only_first_30_laps_of_race