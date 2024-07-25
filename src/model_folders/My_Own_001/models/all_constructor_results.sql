with

constructors as (

    select * from {{ ref('stg_constructors') }}

),

constructor_results as (

    select * from {{ ref('stg_constructor_results') }}

),

joined as (

    select
        constructor_id,
        race_id,
        points

    from constructor_results
    where constructor_id in (

        select
            distinct constructor_id

        from constructors

        )
)

    select * from joined