WITH

accounts AS (

    SELECT * FROM {{ ref('stg_accounts') }}

),

groups AS (

    SELECT * FROM {{ ref('stg_groups') }}

),

joined AS (

    SELECT
        a.account_id,
        a.account_description,
        g.group_id

    FROM accounts AS a
    INNER JOIN groups AS g
        ON a.group_id = g.group_id

)

SELECT * FROM joined
