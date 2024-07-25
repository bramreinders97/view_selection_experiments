WITH

source AS (

    SELECT * FROM {{ source('local_postgres', 'accounts') }}
    ORDER BY id  --necessary for small LIMIT values to ensure the join has rows
    LIMIT {{ var('limit_used_in_experiment')['stg_accounts'] }}

),

renamed AS (

    SELECT
        id AS account_id,
        description AS account_description,
        group_id

    FROM source

)

SELECT * FROM renamed
