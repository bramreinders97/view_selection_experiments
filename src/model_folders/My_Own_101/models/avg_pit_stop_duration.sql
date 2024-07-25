with

all_pitstops as (

    select * from {{ ref('join_pits_stops_lap_times') }}

),

standings as (

    select * from {{ ref('stg_driver_standings') }}

),

joined_with_standings as (

    select
        s.*,
        g.avg_pit_stop_duration

    from (

        select
            driver_id,
            avg(duration) as avg_pit_stop_duration

        from all_pitstops

        group by driver_id

    ) as g

    inner join standings s on g.driver_id = s.driver_id

)

    select * from joined_with_standings