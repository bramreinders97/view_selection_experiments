with

appearances as (

    select * from {{ source('transfermarkt', 'appearances') }}
    order by game_id, player_id
    limit {{ var('limit_used_in_experiment')['stg_appearances'] }}

),

final as (

    select
        game_id,
        player_id

    from appearances

)

    select * from final