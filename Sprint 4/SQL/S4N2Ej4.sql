WITH Filter_Three AS (
    SELECT user_id,
        transaction_timestamp,
        amount,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_timestamp) AS transaction_count
    FROM sprint3_gold.fact_transactions_optimized
    QUALIFY transaction_count <= 3
),
Client_Quality AS (
    SELECT user_id,
        ARRAY_AGG(transaction_timestamp ORDER BY transaction_count DESC LIMIT 1)[OFFSET(0)] AS third_transaction_date,
        ARRAY_AGG(amount ORDER BY transaction_count DESC LIMIT 1)[OFFSET(0)] AS third_transaction_amount,
        AVG(amount) AS average_amount,
    FROM Filter_Three
    GROUP BY user_id
)

SELECT users_combined.user_id,
    CONCAT(users_combined.name, ' ', users_combined.surname) AS nombre_completo,
    users_combined.email,
    Client_Quality.third_transaction_date AS fecha_3a_transaccion,
    Client_Quality.third_transaction_amount AS cantidad_3a_transaccion,
    ROUND(Client_Quality.average_amount, 2) AS media_3_primeras
FROM Client_Quality
JOIN sprint3_silver.users_combined
    ON Client_Quality.user_id = users_combined.user_id
ORDER BY media_3_primeras DESC;