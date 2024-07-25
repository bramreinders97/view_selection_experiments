with

laps_and_drivers as (

    select * from {{ ref('laps_joined_with_drivers') }}

),

driver_id_below_10 as (

    select
        driver_id,
        driver_ref,
        number,
        ms

    from laps_and_drivers
    where driver_id < 10

)

    select * from driver_id_below_10