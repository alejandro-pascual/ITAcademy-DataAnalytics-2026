CREATE OR REPLACE TABLE sprint3_silver.products_clean AS
SELECT id AS product_id,
  product_name AS name,
  SAFE_CAST(REPLACE(warehouse_id, 'WH-', '') AS INT64) AS warehouse_id,
  SAFE_CAST(REGEXP_REPLACE(CAST(price AS STRING), r'[^0-9.]', '') AS FLOAT64) AS price,
  weight
FROM sprint3_bronze.products_raw;