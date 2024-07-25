WITH

transactions AS (

    SELECT * FROM {{ ref('int_union_of_transactions') }}

),

accounts_and_groups_joined AS (

    SELECT * FROM {{ ref('int_accounts_and_groups_joined') }}

),

joined AS (

    SELECT
        t.amount,
        a.account_description,
        a.group_id

    FROM transactions AS t
    INNER JOIN accounts_and_groups_joined AS a
        ON t.account_id = a.account_id

)

SELECT * FROM joined
