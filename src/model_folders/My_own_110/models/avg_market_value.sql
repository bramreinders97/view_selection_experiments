with

market_value as (

    select * from {{ ref('stg_market_value') }}

),

query_to_join as (

    select * from {{ ref('2_group_bys_2_subqueries') }}

),

final as (

    select
        player_id,
        avg(mv) as avg_market_value

    from (

        select
            q.player_id,
            mv

        from market_value m
        join query_to_join q
        on m.player_id = q.player_id

         ) as subquery

    group by player_id

)

    select * from final