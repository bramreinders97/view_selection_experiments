with

laps_better_than_10th as (

    select * from {{ ref('laps_better_than_10th') }}

),

drivers as (

    select * from {{ ref('stg_drivers') }}

),

joined as (

    select
        l.race_id,
        l.driver_id,
        lap,
        position,
        driver_ref,
        number,
        ms

    from laps_better_than_10th l
    join drivers d
    on l.driver_id = d.driver_id

)

    select * from joined