with

drivers as (

    select * from {{ source('f1_dataset', 'drivers') }}
    LIMIT {{ var('limit_used_in_experiment')['stg_drivers'] }}

),

final as (

    select
        driverid as driver_id,
        driverref as driver_ref,
        number,
        nationality

    from drivers

)

    select * from final