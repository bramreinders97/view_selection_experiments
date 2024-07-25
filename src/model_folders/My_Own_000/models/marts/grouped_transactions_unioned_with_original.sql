WITH

grouped AS (

    SELECT * FROM {{ ref('int_grouped_on_group_id') }}

),

original AS (

    SELECT * FROM {{ ref('int_transactions_and_accounts_and_groups_joined') }}

),

unioned AS (

    SELECT
        group_id,
        total_amount,
        account_description

    FROM grouped

    UNION ALL

    SELECT
        group_id,
        amount,
        account_description

    FROM original

)

SELECT * FROM unioned
