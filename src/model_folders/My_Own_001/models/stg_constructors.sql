with

constructors as (

    select * from {{ source('f1_dataset', 'constructors') }}

),

final as (

    select
        constructorid as constructor_id,
        constructorref as constructor_ref

    from constructors

)

    select * from final