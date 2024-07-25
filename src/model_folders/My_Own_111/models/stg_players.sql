with

players as (

    select * from {{ source('transfermarkt', 'players') }}
    order by season, player_id
    limit {{ var('limit_used_in_experiment')['stg_players'] }}

),

final as (

    select
        player_id,
        season

    from players

)

    select * from final