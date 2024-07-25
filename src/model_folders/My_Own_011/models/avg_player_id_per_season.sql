with

ungrouped as (

    select * from {{ ref('only_substitutes') }}

),

grouped as (

    select
        season,
        avg(player_id) as avg_player_id

    from ungrouped
    group by season

)

    select * from grouped
