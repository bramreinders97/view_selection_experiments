WITH

source AS (

    SELECT * FROM {{ source('local_postgres', 'groups') }}
    LIMIT {{ var('limit_used_in_experiment')['stg_groups'] }}

),

renamed AS (

    SELECT
        id AS group_id,
        group_description

    FROM source

)

SELECT * FROM renamed
