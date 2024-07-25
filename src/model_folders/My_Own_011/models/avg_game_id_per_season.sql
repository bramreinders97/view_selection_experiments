with

ungrouped as (

    select * from {{ ref('stg_games') }}

),

grouped as (

    select
        season,
        avg(game_id) as avg_game_id

    from ungrouped
    group by season

)

    select * from grouped
