with

lap_times as (

    select * from {{ source('f1_dataset', 'lap_times') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_lap_times'] }}

),

final as (

    select
        raceid as race_id,
        driverid as driver_id,
        lap,
        position,
        milliseconds as ms

    from lap_times

)

    select * from final