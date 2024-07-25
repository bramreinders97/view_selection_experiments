with

max_season as (

    select * from {{ ref('max_player_id_per_season') }}

),

avg_season as (

    select * from {{ ref('avg_season_per_player') }}

),

appearances as (

    select * from {{ ref('stg_appearances') }}

),

joined as (

    select
        m.player_id,
        max_season,
        avg_season

    from max_season m
    join avg_season a
    on m.player_id = a.player_id

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
