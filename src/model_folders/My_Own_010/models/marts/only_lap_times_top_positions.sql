with

lap_times as (

    select * from {{ ref('stg_lap_times') }}

),

races as (

    select * from {{ ref('stg_races') }}

),

only_top_postitions as (

    select
        r.race_id,
        r.name,
        l.lap,
        l.position

    from lap_times l
    join races r
    on r.race_id = l.race_id

)

    select * from only_top_postitions