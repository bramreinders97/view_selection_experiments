with

all_laps as (

    select * from {{ ref('driver_id_below_10') }}

),

laps_quicker_than_94772_ms as (

    select
        driver_id,
        driver_ref,
        ms

    from all_laps
    where ms < 94772

)

    select * from laps_quicker_than_94772_ms