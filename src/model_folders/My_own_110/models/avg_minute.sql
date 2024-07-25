with

game_events as (

    select * from {{ ref('stg_game_events') }}

),

query_to_join as (

    select * from {{ ref('2_group_bys_2_subqueries') }}

),

final as (

    select
        game_id,
        round(avg(minute)) as avg_minute

    from (

        select
            q.game_id,
            g.minute

        from game_events g
        join query_to_join q
        on g.game_id = q.game_id

         ) as subquery

    group by game_id

)

    select * from final