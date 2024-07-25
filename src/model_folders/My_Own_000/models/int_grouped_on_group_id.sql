WITH

transactions_and_accounts_and_groups AS (

    SELECT * FROM {{ ref('int_transactions_and_accounts_and_groups_joined') }}

),

grouped_on_group_id AS (

    SELECT
        group_id,
        'fixed_value' AS account_description,
        SUM(amount) AS total_amount

    FROM transactions_and_accounts_and_groups

    GROUP BY group_id

)

SELECT * FROM grouped_on_group_id
