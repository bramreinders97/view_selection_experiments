with

avg_minutes as (

    select * from {{ ref('avg_minute') }}

),

game_events as (

    select * from {{ ref('stg_game_events') }}

),

final as (

    select
        avg_minute,
        max(game_id)

    from avg_minutes

    where game_id in (

        select
            distinct game_id

        from game_events

        )

    group by avg_minute

)

    select * from final