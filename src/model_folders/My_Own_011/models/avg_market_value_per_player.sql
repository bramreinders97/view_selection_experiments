with

ungrouped as (

    select * from {{ ref('stg_market_value') }}

),

grouped as (

    select
        player_id,
        avg(market_value) as avg_market_value

    from ungrouped
    group by player_id

)

    select * from grouped
