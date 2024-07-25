with

constructors as (

    select * from {{ ref('stg_constructors') }}

),

not_grouped as (

        select * from {{ ref('join_races_and_race_result_tables') }}

),

avg_positions as (

    select
        constructor_id,
        avg(sprint_position::int) as avg_sprint_position,
        avg(race_position::int) as avg_race_position

    from not_grouped
    group by constructor_id

),

joined_with_constructors as (

    select
        constructors.*,
        avg_positions.avg_sprint_position,
        avg_positions.avg_race_position

    from constructors
    join avg_positions on constructors.constructor_id = avg_positions.constructor_id

)

    select * from joined_with_constructors