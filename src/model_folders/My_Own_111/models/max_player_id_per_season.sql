with

ungrouped as (

    select * from {{ ref('stg_players')}}

),

clubs_with_seasons as (

    select * from {{ ref('stg_clubs')}}

),

grouped as (

    select
        player_id,
        max(season) as max_season

    from ungrouped
    where player_id in (

        select
            distinct player_id

        from ungrouped

        )

    and season in (

        select
            distinct season

        from clubs_with_seasons

        )


    group by player_id

)

    select * from grouped