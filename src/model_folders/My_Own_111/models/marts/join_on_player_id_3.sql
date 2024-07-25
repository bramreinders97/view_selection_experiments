with

avg_market_value as (

    select * from {{ ref('avg_market_value_per_player') }}

),

avg_season as (

    select * from {{ ref('avg_season_per_player') }}

),

appearances as (

    select * from {{ ref('stg_appearances') }}

),

joined as (

    select
        s.player_id,
        avg_season,
        avg_market_value

    from avg_season s
    join avg_market_value mv
    on s.player_id = mv.player_id

),

grouped_again as (

    select
        player_id,
        avg(avg_season)

    from joined
    where player_id in (

        select
            distinct player_id

        from appearances

        )

    group by player_id

)

    select * from grouped_again