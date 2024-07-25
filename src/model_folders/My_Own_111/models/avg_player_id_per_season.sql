with

ungrouped as (

    select * from {{ ref('only_substitutes')}}

),

events_with_season as (

  select * from {{ ref('stg_game_events')}}

),

grouped as (

    select
        season,
        avg(player_id) as avg_player_id

    from ungrouped
    where season in (

        select
            distinct season

        from events_with_season

        )


    group by season

)

    select * from grouped