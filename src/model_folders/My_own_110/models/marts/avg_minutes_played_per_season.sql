with

appearances as (

    select * from {{ ref('stg_appearances') }}

),

avg_minutes as (

    select * from {{ ref('avg_minute') }}

),

market_value as (

    select * from {{ ref('stg_market_value') }}

),

subquery as (

    select
        game_id,
        player_id,
        minutes_played

    from appearances
    where game_id in (

        select
            distinct game_id

        from avg_minutes

        )
),

a_join as (

    select
        s.player_id,
        s.minutes_played,
        m.season

    from market_value m
    join subquery s
    on m.player_id = s.player_id

),

final_group_by as (

    select
        season,
        avg(minutes_played) as avg_minutes_played

    from a_join

    group by season

)

    select * from final_group_by