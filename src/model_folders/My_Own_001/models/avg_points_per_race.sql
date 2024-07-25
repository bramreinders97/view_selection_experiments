with

ungrouped as (

    select * from {{ ref('results_worth_less_than_8_points') }}

),

grouped as (

    select
        race_id,
        avg(points) as avg_points

    from ungrouped
    group by race_id

)

    select * from grouped