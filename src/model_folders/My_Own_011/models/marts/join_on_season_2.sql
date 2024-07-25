with

avg_player_id as (

    select * from {{ ref('avg_player_id_per_season') }}

),

avg_game_id as (

    select * from {{ ref('avg_game_id_per_season') }}

),

joined as (

    select
        g.season,
        avg_player_id,
        avg_game_id

    from avg_player_id p
    join avg_game_id g
    on p.season = g.season

)

    select * from joined