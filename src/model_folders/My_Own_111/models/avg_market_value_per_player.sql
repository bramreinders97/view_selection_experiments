with

ungrouped as (

    select * from {{ ref('stg_market_value')}}

),

players as (

    select * from {{ ref('stg_players')}}

),

grouped as (

    select
        player_id,
        avg(market_value) as avg_market_value

    from ungrouped
    where player_id in (

        select
            distinct player_id

        from players

        )


    group by player_id

)

    select * from grouped