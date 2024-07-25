with

avg_market_value as (

    select * from {{ ref('avg_market_value_per_player') }}

),

avg_game_id as (

    select * from {{ ref('lineups_grouped_by_players') }}

),

appearances as (

    select * from {{ ref('stg_appearances') }}

),

joined as (

    select
        mv.player_id,
        avg_market_value,
        avg_game_id

    from avg_market_value mv
    join avg_game_id g
    on mv.player_id = g.player_id

),

grouped_again as (

    select
        player_id,
        avg(avg_market_value)

    from joined
    where player_id in (

        select
            distinct player_id

        from appearances

        )

    group by player_id

)

    select * from grouped_again