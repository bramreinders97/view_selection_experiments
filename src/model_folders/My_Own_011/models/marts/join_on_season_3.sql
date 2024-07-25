with

avg_game_id as (

    select * from {{ ref('avg_game_id_per_season') }}

),

avg_home_club_goals as (

    select * from {{ ref('avg_home_club_goals_per_season') }}

),

joined as (

    select
        h.season,
        round(avg_game_id) as avg_game_id,
        avg_goals

    from avg_game_id g
    join avg_home_club_goals h
    on g.season = h.season

)

    select * from joined