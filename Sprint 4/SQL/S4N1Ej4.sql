CREATE MATERIALIZED VIEW sprint3_gold.mv_daily_sales AS
SELECT COUNT(transaction_id) AS transactions_count, ROUND(SUM(amount),2) AS total_amount, DATE(transaction_timestamp) AS transaction_date
FROM sprint3_gold.fact_transactions_optimized
GROUP BY transaction_date;

SELECT * FROM sprint3-analytics-alejandro.sprint3_gold.my_daily_sales