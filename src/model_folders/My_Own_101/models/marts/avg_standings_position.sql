with

all_positions as (

    select * from {{ ref('avg_pit_stop_duration') }}

),

avg_position_with_subquery as (

    select
        driver_id,
        avg(position) as avg_position

    from (

        select *
        from all_positions
        where driver_id <> 341 -- so everyone

    ) as still_everythiing

    group by driver_id

)

    select * from avg_position_with_subquery