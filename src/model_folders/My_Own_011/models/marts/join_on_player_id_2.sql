with

avg_game_id as (

    select * from {{ ref('lineups_grouped_by_players') }}

),

max_season as (

    select * from {{ ref('max_player_id_per_season') }}

),

joined as (

    select
        ms.player_id,
        avg_game_id,
        max_season

    from avg_game_id g
    join max_season ms
    on g.player_id = ms.player_id

)

    select * from joined
