CREATE OR REPLACE TABLE sprint3_silver.transactions_clean AS
SELECT id AS transaction_id,
  IFNULL(SAFE_CAST(amount AS FLOAT64), 0) AS amount,
  SAFE_CAST(timestamp AS TIMESTAMP) AS transaction_timestamp,
  SAFE_CAST(lat AS FLOAT64) AS lat,
  SAFE_CAST(longitude AS FLOAT64) AS longitude,
  ARRAY(
    SELECT SAFE_CAST(TRIM(id) AS INT64)
    FROM UNNEST(SPLIT(product_ids, ',')) AS id
    WHERE SAFE_CAST(TRIM(id) AS INT64) IS NOT NULL
  ) AS product_ids_array,
  user_id,
  card_id,
  business_id,
  declined,
  
  FROM sprint3_bronze.transactions_raw;   