with

ungrouped as (

    select * from {{ ref('stg_players') }}

),

grouped as (

    select
        player_id,
        avg(season) as avg_season

    from ungrouped
    group by player_id

)

    select * from grouped