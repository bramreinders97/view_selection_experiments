with

lineups as (

    select * from {{ source('transfermarkt', 'game_lineups') }}
    order by game_id, player_id
    limit {{ var('limit_used_in_experiment')['stg_lineups'] }}

),

final as (

    select
        game_id,
        season,
        player_id,
        club_id,
        type

    from lineups

)

    select * from final