with

avg_pos_per_constructor as (

    select * from {{ ref('avg_sprint_and_race_pos_constructors') }}

),

grouped_on_nationality as (

    select
        nationality,
        avg(avg_sprint_position) as avg_sprint_position,
        avg(avg_race_position) as avg_race_position

    from avg_pos_per_constructor
    group by nationality

)

    select * from grouped_on_nationality