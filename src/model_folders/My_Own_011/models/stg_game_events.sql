with

game_events as (

    select * from {{ source('transfermarkt', 'game_events') }}
    order by game_id
    LIMIT {{ var('limit_used_in_experiment')['stg_game_events'] }}

),

final as (

    select
        game_id,
        minute,
        season,
        club_id,
        player_id,
        type as event_type

    from game_events

)

    select * from final