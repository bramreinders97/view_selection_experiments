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
        avg(home_club_goals) as avg_goals

    from ungrouped
    where season in (

        select
            distinct season

        from clubs_with_season

        )

    group by season

)

    select * from grouped