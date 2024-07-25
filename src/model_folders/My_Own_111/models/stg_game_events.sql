with

events as (

    select * from {{ source('transfermarkt', 'game_events') }}
    order by game_id
    limit {{ var('limit_used_in_experiment')['stg_game_events'] }}

),

final as (

    select
        game_id,
        season,
        player_id

    from events

)

    select * from final