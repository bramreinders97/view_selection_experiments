with

races as (

    select * from {{ ref('stg_races') }}

),

pit_stops as (

    select * from {{ ref('stg_pit_stops') }}

),

only_sub_24s as (

    select
        r.race_id,
        r.name,
        p.ms

    from races r
    join pit_stops p
    on r.race_id = p.race_id

)

    select * from only_sub_24s