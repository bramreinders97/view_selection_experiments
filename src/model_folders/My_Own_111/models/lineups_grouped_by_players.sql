with

ungrouped as (

    select * from {{ ref('stg_lineups') }}

),

players as (

    select * from {{ ref('stg_players')}}

),

grouped as (

    select
        player_id,
        avg(game_id) as avg_game_id

    from ungrouped
    where player_id in (

        select
            distinct player_id

        from players

        )

    group by player_id

)

    select * from grouped