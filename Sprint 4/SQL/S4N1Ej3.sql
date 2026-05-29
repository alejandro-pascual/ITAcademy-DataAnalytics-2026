SELECT *
FROM sprint3_silver.transactions_recent
WHERE transaction_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
;

SELECT *
FROM sprint3_gold.fact_transactions_optimized
WHERE transaction_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
;