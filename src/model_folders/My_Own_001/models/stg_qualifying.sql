with

qualifying as (

    select * from {{ source('f1_dataset', 'qualifying') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_qualifying'] }}

),

final as (

    select
        raceid as race_id,
        driverid as driver_id,
        constructorid as constructor_id,
        number

    from qualifying

)

    select * from final