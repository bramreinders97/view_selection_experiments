with

lap_times as (

    select * from {{ ref('stg_lap_times') }}

),

drivers as (

    select * from {{ ref('stg_drivers') }}

),

join_and_group as (

    select
        d.driver_id,
        d.nationality,
        avg(l.ms) as avg_ms

    from lap_times l
    join drivers d
    on l.driver_id = d.driver_id

    group by d.driver_id, d.nationality

)

    select * from join_and_group