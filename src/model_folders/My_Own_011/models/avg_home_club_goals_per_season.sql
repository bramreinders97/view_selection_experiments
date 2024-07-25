with

ungrouped as (

    select * from {{ ref('stg_games') }}

),

grouped as (

    select
        season,
        avg(home_club_goals) as avg_goals

    from ungrouped
    group by season

)

    select * from grouped