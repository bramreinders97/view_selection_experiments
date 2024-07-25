with

market_value as (

    select * from {{ source('transfermarkt', 'market_value_development') }}
    order by season, player_id
    limit {{ var('limit_used_in_experiment')['stg_market_value'] }}

),

final as (

    select
        player_id,
        season,
        market_value_in_eur as market_value

    from market_value

)

    select * from final
