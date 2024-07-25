with

ungrouped as (

    select * from {{ ref('stg_market_value') }}

),

grouped as (

    select
        season,
        avg(market_value) as avg_market_value

    from ungrouped
    group by season

)

    select * from grouped
