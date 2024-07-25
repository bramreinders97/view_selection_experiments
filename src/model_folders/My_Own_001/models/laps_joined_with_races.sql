with

laps as (

    select * from {{ ref('only_first_30_laps_of_races') }}

),

races as (

    select * from {{ ref('stg_races') }}

),

joined as (

    select
        l.race_id,
        round,
        name

    from laps l
    join races r
    on l.race_id = r.race_id

)

    select * from joined