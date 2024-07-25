with

drivers as (

    select * from {{ ref('stg_drivers') }}

),

not_grouped as (

        select * from {{ ref('join_races_and_race_result_tables') }}

),

avg_positions as (

    select
        driver_id,
        avg(sprint_position::int) as avg_sprint_position,
        avg(race_position::int) as avg_race_position

    from not_grouped
    group by driver_id

),

joined_with_drivers as (

    select
        drivers.*,
        avg_positions.avg_sprint_position,
        avg_positions.avg_race_position

    from drivers
    join avg_positions on drivers.driver_id = avg_positions.driver_id

)

    select * from joined_with_drivers