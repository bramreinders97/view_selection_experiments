with races as (

    select * from {{ source('f1_dataset', 'races') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_races'] }}

),

final as (

    select
        raceid as race_id,
        year,
        round,
        circuitid as circuit_id

    from races

)

    select * from final