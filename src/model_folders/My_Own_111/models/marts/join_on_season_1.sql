with

avg_player_id as (

    select * from {{ ref('avg_player_id_per_season') }}

),

avg_market_value as (

    select * from {{ ref('avg_market_value_per_season') }}

),

joined as (

    select
        p.season,
        avg_player_id,
        avg_market_value

    from avg_player_id p
    join avg_market_value mv
    on p.season = mv.season

),

grouped_again as (

    select
        season,
        avg(avg_market_value)

    from joined
    group by season

)

    select * from grouped_again
