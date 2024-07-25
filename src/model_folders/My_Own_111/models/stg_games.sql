with

games as (

    select * from {{ source('transfermarkt', 'games') }}
    order by game_id
    limit {{ var('limit_used_in_experiment')['stg_games'] }}

),

final as (

    select
        game_id,
        season,
        home_club_goals

    from games

)

    select * from final