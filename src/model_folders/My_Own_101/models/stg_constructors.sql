with

constructors as (

    select * from {{ source('f1_dataset', 'constructors') }}
    LIMIT {{ var('limit_used_in_experiment')['stg_constructors'] }}

),

final as (

    select
        constructorid as constructor_id,
        constructorref as constructor_ref,
        nationality

    from constructors

)

    select * from final