with

ungrouped as (

    select * from {{ ref('stg_games')}}

),

clubs_with_season as (

    select * from {{ ref('stg_clubs')}}

),

grouped as (

    select
        season,
        avg(game_id) as avg_game_id

    from ungrouped
    where season in (

        select
            distinct season

        from clubs_with_season

        )

    group by season

)

    select * from grouped