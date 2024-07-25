with

everybody as (

    select * from {{ ref('join_qualy_constr_drivers') }}

),

best_constr_and_drivers as (

    select
        driver_id,
        constructor_id

    from everybody

    where driver_id in (

        select
            driver_id

        from everybody

        group by driver_id
        having avg(position) < 10

    )

    and constructor_id in (

        select
            constructor_id

        from everybody

        group by constructor_id
        having avg(position) < 8

    )

)

    select * from best_constr_and_drivers
