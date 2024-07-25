with

races as (

    select * from {{ ref('stg_races') }}

),

race_results as (

    select * from {{ ref('stg_results') }}

),

sprint_results as (

    select * from {{  ref('stg_sprint_results') }}

),

joined as (

    select
        all_results.*,
        races.circuit_id

    from (
            select
                r.race_id,
                r.position as race_position,
                s.position as sprint_position,
                s.driver_id,
                s.constructor_id

            from race_results r
            join sprint_results s
                on r.race_id = s.race_id
                and r.driver_id = s.driver_id

         ) as all_results

    join races on all_results.race_id = races.race_id

)

    select * from joined