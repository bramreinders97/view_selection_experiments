with

ungrouped as (

    select * from {{ ref('stg_market_value')}}

),

clubs_with_seasons as (

    select * from {{ ref('stg_clubs')}}

),

grouped as (

    select
        season,
        avg(market_value) as avg_market_value

    from ungrouped
    where season in (

        select
            distinct season

        from clubs_with_seasons

        )

    group by season

)

    select * from grouped