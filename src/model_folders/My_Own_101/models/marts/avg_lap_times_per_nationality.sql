with

ungrouped as (

    select * from {{ ref('avg_lap_times_drivers') }}

),

grouped as (

    select
        nationality,
        count(*) as n_drivers_nationality,
        avg(avg_ms) as avg_ms_nationality

    from ungrouped

    group by nationality

)

    select * from grouped