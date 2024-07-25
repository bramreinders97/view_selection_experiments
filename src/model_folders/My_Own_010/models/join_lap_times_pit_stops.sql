with

lap_times as (

    select * from {{ ref('stg_lap_times') }}

),

pit_stops as (

    select * from {{ ref('stg_pit_stops') }}

),

joined as (

    select
        l.driver_id,
        l.race_id,
        l.lap,
        l.position,
        l.ms as lap_ms,
        p.ms as pits_ms

    from lap_times l
    join pit_stops p on l.driver_id = p.driver_id
    and l.race_id = p.race_id

)

    select * from joined
