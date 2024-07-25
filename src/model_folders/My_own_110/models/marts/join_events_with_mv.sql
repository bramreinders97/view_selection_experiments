with

events as (

    select * from {{ ref('stg_game_events') }}

),

market_values as (

    select * from {{ ref('avg_market_value') }}

),

avg_minute as (

    select * from {{ ref('avg_minute') }}

),

final as (

    select
        e.*,
        mv.avg_market_value

    from events e
    join market_values mv
    on e.player_id = mv.player_id

    where game_id in (

        select
            distinct game_id

        from avg_minute

        )
)

    select * from final