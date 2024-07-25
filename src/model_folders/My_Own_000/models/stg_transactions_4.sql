WITH

source AS (

    SELECT * FROM {{ source('local_postgres', 'transactions_4') }}
    LIMIT {{ var('limit_used_in_experiment')['stg_transactions_4'] }}

),

renamed AS (

    SELECT
        id AS transaction_id,
        amount,
        account_id

    FROM source

)

SELECT * FROM renamed
