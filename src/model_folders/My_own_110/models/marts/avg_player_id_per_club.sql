with

lineups as (

    select * from {{ ref('stg_lineups') }}

),

avg_market_value as (

    select * from {{ ref('avg_market_value') }}

),

final as (

    select
        club_id,
        avg(player_id) avg_player_id


    from lineups
    where player_id in (

        select
            distinct player_id

        from avg_market_value

        )

    group by club_id

)

    select * from final