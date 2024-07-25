with

avg_round as (

    select * from {{ ref('avg_round_per_race_id') }}

),

avg_points as (

    select * from {{ ref('avg_points_per_race') }}

),

joined as (

    select
        r.race_id,
        avg_round,
        avg_points

    from avg_round r
    join avg_points p
    on r.race_id = p.race_id

)

    select * from joined