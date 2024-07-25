with

avg_market_value as (

    select * from {{ ref('avg_market_value_per_player') }}

),

avg_game_id as (

    select * from {{ ref('lineups_grouped_by_players') }}

),

joined as (

    select
        mv.player_id,
        avg_market_value,
        avg_game_id

    from avg_market_value mv
    join avg_game_id g
    on mv.player_id = g.player_id

)

    select * from joined