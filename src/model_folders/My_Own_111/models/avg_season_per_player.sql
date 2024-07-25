with

ungrouped as (

    select * from {{ ref('stg_players')}}

),

events_with_player_id as (

    select * from {{ ref('stg_game_events')}}

),

market_value_with_seasons as (

    select * from {{ ref('stg_market_value')}}

),

grouped as (

    select
        player_id,
        avg(season) as avg_season

    from ungrouped
    where player_id in (

        select
            distinct player_id

        from events_with_player_id

        )

    and season in (

        select
            distinct season

        from market_value_with_seasons

        )

    group by player_id

)

    select * from grouped