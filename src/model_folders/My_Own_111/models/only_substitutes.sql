with

all_types as (

    select * from {{ ref('stg_lineups')}}

),

players as (

select * from {{ ref('stg_players')}}

),

only_subs as (

    select
        player_id,
        season

    from all_types
    where type='substitute'
    and player_id in (

        select
            distinct player_id

        from players

        )

)

    select * from only_subs