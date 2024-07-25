with

avg_game_id as (

    select * from {{ ref('avg_game_id_per_season') }}

),

avg_home_club_goals as (

    select * from {{ ref('avg_home_club_goals_per_season') }}

),

game_events as (

    select * from {{ ref('stg_game_events') }}

),

joined as (

    select
        h.season,
        round(avg_game_id) as avg_game_id,
        avg_goals

    from avg_game_id g
    join avg_home_club_goals h
    on g.season = h.season

),

final as (

    select
        season,
        avg_game_id

    from joined
    where avg_game_id < (

        select
            max(player_id)

        from game_events

        )

)

    select * from final