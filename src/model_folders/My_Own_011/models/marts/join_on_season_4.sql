with

avg_home_club_goals as (

    select * from {{ ref('avg_home_club_goals_per_season') }}

),

avg_market_value as (

    select * from {{ ref('avg_market_value_per_season') }}

),

joined as (

    select
        mv.season,
        avg_goals,
        avg_market_value

    from avg_home_club_goals hcg
    join avg_market_value mv
    on hcg.season = mv.season

)

    select * from joined