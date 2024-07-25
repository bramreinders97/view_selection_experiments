with

avg_game_id as (

    select * from {{ ref('lineups_grouped_by_players') }}

),

max_season as (

    select * from {{ ref('max_player_id_per_season') }}

),

appearances as (

    select * from {{ ref('stg_appearances') }}

),

joined as (

    select
        ms.player_id,
        avg_game_id,
        max_season

    from avg_game_id g
    join max_season ms
    on g.player_id = ms.player_id

),

grouped_again as (

    select
        player_id,
        avg(max_season)

    from joined
    where player_id in (

        select
            distinct player_id

        from appearances

        )

    group by player_id

)

    select * from grouped_again
