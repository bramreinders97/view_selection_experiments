with

max_season as (

    select * from {{ ref('max_player_id_per_season') }}

),

avg_season as (

    select * from {{ ref('avg_season_per_player') }}

),

joined as (

    select
        m.player_id,
        max_season,
        avg_season

    from max_season m
    join avg_season a
    on m.player_id = a.player_id

)

    select * from joined
