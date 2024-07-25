with

game_events as (

    select * from {{ source('transfermarkt', 'game_events') }}
    order by game_id
    limit {{ var('limit_used_in_experiment')['stg_game_events'] }}

),

final as (

    select
        game_id,
        player_id,
        minute,
        season

    from game_events

)

    select * from final