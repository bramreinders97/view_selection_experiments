with

ungrouped as (

    select * from {{ ref('stg_lineups') }}

),

grouped as (

    select
        player_id,
        avg(game_id) as avg_game_id

    from ungrouped
    group by player_id

)

    select * from grouped