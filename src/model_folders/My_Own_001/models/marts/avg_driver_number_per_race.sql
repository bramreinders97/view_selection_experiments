with

ungrouped as (

    select * from {{ ref('only_race_qualy_combis_with_driver_number_below_10') }}

),

grouped as (

    select
        race_id,
        avg(number) as avg_driver_number

    from ungrouped
    group by race_id

)

    select * from grouped