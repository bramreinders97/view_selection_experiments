with

pit_stops as (

    select * from {{ source('f1_dataset', 'pit_stops') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_pit_stops'] }}

),

final as (

    select
        raceid as race_id,
        driverid as driver_id,
        stop,
        time,
        duration::float as duration

    from pit_stops

)

    select * from final