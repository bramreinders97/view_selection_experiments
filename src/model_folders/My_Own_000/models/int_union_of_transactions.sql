WITH

transactions_1 AS (

    SELECT * FROM {{ ref('stg_transactions_1') }}

),

transactions_2 AS (

    SELECT * FROM {{ ref('stg_transactions_2') }}

),

transactions_3 AS (

    SELECT * FROM {{ ref('stg_transactions_3') }}

),

transactions_4 AS (

    SELECT * FROM {{ ref('stg_transactions_4') }}

),

union_of_all_transactions AS (

    SELECT
        transaction_id,
        amount,
        account_id,
        1 AS company_id
    FROM transactions_1

    UNION ALL

    SELECT
        transaction_id,
        amount,
        account_id,
        2 AS company_id
    FROM transactions_2

    UNION ALL

    SELECT
        transaction_id,
        amount,
        account_id,
        3 AS company_id
    FROM transactions_3

    UNION ALL

    SELECT
        transaction_id,
        amount,
        account_id,
        4 AS company_id
    FROM transactions_4

)

SELECT * FROM union_of_all_transactions
