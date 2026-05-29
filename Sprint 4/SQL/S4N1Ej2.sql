CREATE OR REPLACE TABLE sprint3-analytics-alejandro.sprint3_silver.transactions_recent AS
SELECT * EXCEPT(transaction_timestamp), TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL CAST (RAND() * 50 AS INT64) DAY) AS transaction_timestamp
FROM sprint3_silver.transactions_clean;


CREATE OR REPLACE TABLE sprint3-analytics-alejandro.sprint3_gold.fact_transactions_optimized
PARTITION BY DATE(transaction_timestamp)
CLUSTER BY business_id AS
SELECT *
FROM sprint3-analytics-alejandro.sprint3_silver.transactions_recent;