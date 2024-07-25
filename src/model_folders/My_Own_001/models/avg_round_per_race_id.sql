with

ungrouped as (

    select * from {{ ref('laps_joined_with_races') }}

),

grouped as (

    select
        race_id,
        avg(round) as avg_round

    from ungrouped

    group by race_id

)

    select * from grouped