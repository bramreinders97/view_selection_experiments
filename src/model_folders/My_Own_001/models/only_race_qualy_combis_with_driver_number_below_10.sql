with

all_numbers_present as (

    select * from {{ ref('qualy_joined_with_pit_stops_and_constructor_results') }}

),

high_numbers_removed as (

    select
        race_id,
        points,
        number,
        driver_id

    from all_numbers_present
    where number < 10

)

    select * from high_numbers_removed