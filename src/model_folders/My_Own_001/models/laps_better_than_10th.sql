with

lap_times as (

    select * from {{ ref('stg_lap_times') }}

),

final as (

    select
        race_id,
        driver_id,
        lap,
        position,
        ms

    from lap_times
    where position < 10

)

    select * from final