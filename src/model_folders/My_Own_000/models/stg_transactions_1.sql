WITH

source AS (

    SELECT * FROM {{ source('local_postgres', 'transactions_1') }}
    ORDER BY id  --necessary for small LIMIT values to ensure the join has rows
    LIMIT {{ var('limit_used_in_experiment')['stg_transactions_1'] }}

),

renamed AS (

    SELECT
        id AS transaction_id,
        amount,
        account_id

    FROM source

)

SELECT * FROM renamed
