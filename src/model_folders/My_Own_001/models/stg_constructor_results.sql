with

constructor_results as (

    select * from {{ source('f1_dataset', 'constructor_results') }}
    order by raceid desc
    LIMIT {{ var('limit_used_in_experiment')['stg_constructor_results'] }}

),

renamed as (

    select
        constructorid as constructor_id,
        raceid as race_id,
        points

    from constructor_results

)

    select * from renamed
