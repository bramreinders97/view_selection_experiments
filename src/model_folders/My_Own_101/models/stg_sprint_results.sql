with

sprint_results as (

    select * from {{  source('f1_dataset', 'sprint_results') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_sprint_results'] }}

),

final as (

    select
        resultid as result_id,
        raceid as race_id,
        driverid as driver_id,
        constructorid as constructor_id,
        number,
        COALESCE(
            CASE
                WHEN position = '\N' THEN NULL
                ELSE position
            END, '20')
        AS position

    from sprint_results
)

    select * from final