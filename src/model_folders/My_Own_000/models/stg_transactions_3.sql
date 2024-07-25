WITH

source AS (

    SELECT * FROM {{ source('local_postgres', 'transactions_3') }}
    LIMIT {{ var('limit_used_in_experiment')['stg_transactions_3'] }}

),

renamed AS (

    SELECT
        id AS transaction_id,
        amount,
        account_id

    FROM source

)

SELECT * FROM renamed
