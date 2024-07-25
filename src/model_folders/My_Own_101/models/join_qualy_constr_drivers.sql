with

qualifying as (

    select * from {{ ref('stg_qualifying') }}

),

drivers as (

    select * from {{ ref('stg_drivers') }}

),

constructors as (

    select * from {{ ref('stg_constructors') }}

),

joined_with_subquery as (

    select
        q.*,
        c.constructor_ref,
        d.driver_ref

    from (

        select *
        from qualifying
        where driver_id in (

                select driver_id
                from drivers
                where nationality <> 'Korean'
        --         so everybody

            )

    ) as q

    join constructors c on c.constructor_id = q.constructor_id
    join drivers d on d.driver_id = q.driver_id

)

    select * from joined_with_subquery