with

avg_player_id as (

    select * from {{ ref('avg_player_id_per_season') }}

),

avg_game_id as (

    select * from {{ ref('avg_game_id_per_season') }}

),

game_events as (

    select * from {{ ref('stg_game_events') }}

),

joined as (

    select
        g.season,
        avg_player_id,
        avg_game_id

    from avg_player_id p
    join avg_game_id g
    on p.season = g.season

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