with

driver_standings as (

    select * from {{ source('f1_dataset', 'driver_standings') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_driver_standings'] }}

),

final as (

    select
        driverstandingsid as driver_standings_id,
        raceid as race_id,
        driverid as driver_id,
        position::int as position

    from driver_standings

)

    select * from final