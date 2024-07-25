with

ungrouped as (

    select * from {{ ref('only_race_qualy_combis_with_driver_number_below_10') }}

),

grouped as (

    select
        driver_id,
        avg(points) as avg_points

    from ungrouped
    group by driver_id

)

    select * from grouped